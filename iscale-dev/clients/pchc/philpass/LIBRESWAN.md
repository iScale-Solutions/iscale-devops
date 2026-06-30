# LibreSwan VPN Gateway — Setup Reference (current)

> **✅ Current approach.** This document describes the VPN gateway as it runs today: **LibreSwan on Amazon Linux 2023** (kernel 6.1) using **route-based IPsec (VTI)** with **nftables** for SNAT. It supersedes the legacy **[STRONGSWAN.md](STRONGSWAN.md)** (StrongSwan on AL2, policy-based IPsec, iptables MASQUERADE on `eth0`), which is retained only for historical reference.
>
> Many CloudFormation logical IDs and parameters still carry the legacy `Strongswan*` name (e.g. `StrongswanAMI`, `StrongswanActive`, `StrongSwanInstanceAZ1`); these are names only — the running engine is LibreSwan.

This document describes how the IPsec VPN gateway is configured within the PhilPass stack. Two EC2 instances (one per Availability Zone) run LibreSwan to establish IPsec tunnels between PCHC's AWS VPC and the Bangko Sentral ng Pilipinas (BSP) network.

## Overview

```
PCHC VPC (private subnets)
        │
        ├── Route table AZ1 ──► Gateway ENI (AZ1, fixed private IP) ──► EIP1
        └── Route table AZ2 ──► Gateway ENI (AZ2, fixed private IP) ──► EIP2
                                        │
                       nftables SNAT (masquerade) onto VTI
                                        │
                           IPsec tunnels (IKEv1, PSK)
                                        │
                         ┌──────────────┼──────────────┐
                      PPP tunnel    PPP DR tunnel   3rd Party tunnel
                    (bspPPPlus)   (bspPPPlusDR)     (bspPP3rd)
                       vti0           vti1             vti2
                         │              │                │
                  121.127.5.157  121.127.17.175    121.127.5.50
```

The gateway acts as a **NAT-T gateway**: traffic from the private subnets is masqueraded (SNAT) to the gateway instance's registered IP as it egresses the VTI, so it matches the tunnel's IPsec policy. `SourceDestCheck` is disabled on the ENIs to allow forwarding.

## Why VTI on kernel 6.1

The legacy design relied on **policy-based IPsec**: the kernel decides whether to encrypt a packet by matching its source/destination against the policy selector (`leftsubnet` → `rightsubnet`). A private instance's real source (the private `/27`) is **not** in `leftsubnet` (the public `/27` registered with BSP), so the MASQUERADE had to rewrite the source to the gateway IP **before** the XFRM policy check ran.

- **On kernel 4.14 (AL2) this worked.** When NAT changed a packet's source, netfilter triggered a route re-evaluation late in the output path that re-ran the XFRM policy lookup against the already-masqueraded source. Order was effectively: MASQUERADE → XFRM encrypt. The masqueraded source matched `leftsubnet`, so the packet entered the tunnel.
- **On kernel 6.1 (AL2023) it broke.** The XFRM policy decision for forwarded traffic is evaluated against the **original, pre-NAT source**, before the POSTROUTING masquerade takes effect. The selector no longer matches, so the packet bypasses the tunnel and leaves in cleartext. Because this check lives in the network stack itself (not a netfilter hook), it **cannot** be reordered by changing nftables chain priorities.

**VTI (route-based IPsec) removes the dependency.** Encryption is bound to the output **interface** (+ a per-connection `mark`), not to a source-address policy match. Traffic is routed into a `vtiN` device; anything egressing that device is encrypted by that tunnel's SA. NAT is applied as the packet leaves the VTI, so the NAT-vs-XFRM ordering question disappears.

## Fixed IPs and EIPs

The ENI private IPs and Elastic IPs are **registered with BSP** and must not change.

| Resource | Production | UAT |
|---|---|---|
| Gateway ENI private IP — AZ1 | `10.0.0.53` | `10.2.0.53` |
| Gateway ENI private IP — AZ2 | `10.0.0.176` | `10.2.0.176` |
| Gateway public subnet — AZ1 | `10.0.0.32/27` | `10.2.0.32/27` |
| Gateway public subnet — AZ2 | `10.0.0.160/27` | `10.2.0.160/27` |
| Gateway private subnet — AZ1 | `10.0.0.0/27` | `10.2.0.0/27` |
| Gateway private subnet — AZ2 | `10.0.0.128/27` | `10.2.0.128/27` |

The public subnet `/27` is the IPsec `leftsubnet`; the ENI IP falls inside it. The private subnet `/27` is the masquerade **source** set — private-instance traffic is SNATed to the ENI IP (which is inside `leftsubnet`) so it matches the SA.

The two Elastic IPs (`BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2`) are created with `DeletionPolicy: Retain`. They survive stack deletion and must be pre-registered with BSP before the stack is first deployed. Do not release or reassign them.

## IPsec Tunnel Configuration

### Cipher Suites

All tunnels use the same algorithms:

| Phase | Algorithm |
|---|---|
| IKE (Phase 1) | `aes256-sha256-modp2048` |
| ESP (Phase 2) | `aes128-sha256-modp2048` |
| Key exchange | IKEv1 (`ikev2=no`) |
| Authentication | Pre-shared key (PSK) |
| IKE lifetime | 43200s (12 hours) |
| SA lifetime | 1h (`salifetime`) |
| DPD | `dpddelay=10`, `dpdtimeout=60`, `dpdaction=restart` |
| Encapsulation | `encapsulation=yes` (NAT-T / force UDP encap) |

Each `conn` is route-based and pinned to its own VTI with a unique XFRM mark:

```
left=%defaultroute
leftid=@pchc
leftsubnet=<gateway public /27>
mark=<unique>/0xffffffff
vti-interface=vti<N>
vti-routing=yes
vti-shared=no
```

### VTI / mark assignment

Marks and interface names are node-local and assigned in connection order per config:

| Config | `bspPPPlus` | `bspPPPlusDR` | `bspPP3rd` |
|---|---|---|---|
| Production (AZ1 & AZ2) | `vti0` / mark `42` | `vti1` / mark `43` | `vti2` / mark `44` |
| UAT (AZ1 & AZ2) | `vti0` / mark `42` | *(not created)* | `vti1` / mark `43` |

### Tunnels

#### `bspPPPlus` — PhilPassPlus Main

| Field | Production | UAT |
|---|---|---|
| Remote gateway (`right`) | `121.127.5.157` | `121.127.5.157` |
| Remote subnet (`rightsubnet`) | `192.168.80.0/24` | `192.168.222.0/24` |
| PSK parameter | `StrongswanPPPPSK` | `StrongswanPPPPSK` |

#### `bspPPPlusDR` — PhilPassPlus Disaster Recovery (Production only)

| Field | Value |
|---|---|
| Remote gateway (`right`) | `121.127.17.175` |
| Remote subnet (`rightsubnet`) | `192.168.90.0/24` |
| PSK parameter | `StrongswanPPPPSK` (same key as main PPP) |

This tunnel is not created in UAT mode.

#### `bspPP3rd` — 3rd Party

| Field | Production | UAT |
|---|---|---|
| Remote gateway (`right`) | `121.127.5.50` | `121.127.5.50` |
| Remote subnet (`rightsubnet`) | `192.168.4.0/24` | `192.168.222.0/24` |
| PSK parameter | `Strongswan3RDPSK` | `Strongswan3RDPSK` |

### `ipsec.secrets` format

```
@pchc <PPP_GATEWAY>    : PSK "<StrongswanPPPPSK>"
@pchc <PPP_DR_GATEWAY> : PSK "<StrongswanPPPPSK>"
@pchc <3RD_GATEWAY>    : PSK "<Strongswan3RDPSK>"
```

The left identity is always `@pchc`. This is written to `/etc/ipsec.d/ipsec.secrets` (mode `0600`) via cfn-init and is not stored in plaintext anywhere in the stack — the values come from the `StrongswanPPPPSK` and `Strongswan3RDPSK` CloudFormation parameters (`NoEcho: true`).

## NAT / nftables Rules

Each instance applies a single nftables POSTROUTING masquerade rule so that traffic from the private subnet appears to originate from the gateway's registered IP when it enters the tunnel. NAT is matched on the **VTI output interface**, not on the destination subnet:

**`/etc/nftables.conf`:**
```
table ip nat {
    set source_subnet {
        type ipv4_addr;
        flags interval;
        elements = { <gateway private /27> }
    }
    chain POSTROUTING {
        type nat hook postrouting priority 100;
        ip saddr @source_subnet oifname "vti*" masquerade
    }
}
```

Notes on this design:

- **`oifname "vti*"` (not `oif "vtiN"`).** `oif` resolves an interface name to an index **at ruleset-load time**; because nftables loads before LibreSwan creates the VTI devices (`01_load_nftables` runs before `02_start_ipsec`), `oif "vti0"` fails with `Interface does not exist`. `oifname` matches the name string **at runtime**, so the rule loads regardless of order.
- **One wildcard rule covers every tunnel.** Adding more tunnels/destinations adds no rules. The legacy iptables design needed one MASQUERADE rule per destination subnet (a `destination_subnet` set) because all tunnels shared `eth0`; with one VTI per tunnel the output interface already scopes the traffic, so a per-destination match is unnecessary.
- **`source_subnet` scoping is preserved** so only private-instance traffic is masqueraded — the gateway's own traffic is untouched.

Rules are applied at boot via:
```bash
nft -f /etc/nftables.conf && systemctl enable --now nftables
```

## Route Table Entries

Private route tables in both AZs get host routes for each BSP resource IP pointing at the gateway ENI in the same AZ. These routes are conditional:

| Route | Condition |
|---|---|
| `BSP3rdPartyRoute` (AZ1 + AZ2) | `IsStrongswanActive` |
| `PPPResource1Route` (AZ1 + AZ2) | `IsStrongswanActive` |
| `PPPResource2–6Routes` (AZ1 + AZ2) | `IsBSPProd` (Production BSP mode only) |
| `PPPDRResource1–4Routes` (AZ1 + AZ2) | `IsBSPProd` |
| `BSPPhilPassPlusDNS1/2Routes` (AZ1 + AZ2) | Always (no condition) |

## Bootstrapping via cfn-init

Instance `UserData` calls `cfn-init` with one of four configSets depending on AZ and BSP mode:

| ConfigSet | Used when |
|---|---|
| `AZ1ConfigProd` | AZ1 instance, `BSPMode=Production` |
| `AZ2ConfigProd` | AZ2 instance, `BSPMode=Production` |
| `AZ1ConfigUAT` | AZ1 instance, `BSPMode=UAT` |
| `AZ2ConfigUAT` | AZ2 instance, `BSPMode=UAT` |

Each configSet runs the following steps in order:

```
InstallPackages → NetworkFiles → PSK → AZxConfig[Prod|UAT] → StartLibreSwan
```

### Step 1 — `InstallPackages`

Installs the gateway packages via yum:

```
libreswan
nftables
```

### Step 2 — `NetworkFiles`

Enables IP forwarding, disables redirects on `ens5` (AL2023 interface name), and applies a persisted sysctl hardening file:

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/ens5/send_redirects
sysctl --system
```

Writes `/etc/sysctl.d/99-ipsec-vpn.conf`, which persists `ip_forward`, disables accept/send redirects and source routing, enables reverse-path filtering, and sets ICMP/ASLR hardening across reboots.

### Step 3 — `PSK`

Writes `/etc/ipsec.d/ipsec.secrets` (mode `0600`) with the PSK entries for all remote gateways.

### Step 4 — `AZxConfig[Prod|UAT]`

Writes two files (permissions `0644`, owned by `root`):

- `/etc/nftables.conf` — the source-scoped VTI masquerade rule for this AZ/mode
- `/etc/ipsec.d/ipsec.conf` — full tunnel configuration (VTI + mark per conn) for this AZ/mode

### Step 5 — `StartLibreSwan`

```bash
nft -f /etc/nftables.conf && systemctl enable --now nftables   # 01_load_nftables
systemctl enable --now ipsec                                    # 02_start_ipsec (ignoreErrors: true)
```

`cfn-hup` is also started to listen for stack metadata changes and re-run cfn-init when the stack is updated.

## Security Group

The `StrongSwanSecurityGroup` has no inbound rules by default. The following ingress rules are added conditionally when `StrongswanActive=true`:

| Protocol | Port | Source | Purpose |
|---|---|---|---|
| ICMP | all | VPC CIDR | Ping/health checks from within VPC |
| TCP | 443 | VPC CIDR | HTTPS from BSP Interface and internal services |
| UDP | 53 | VPC CIDR | DNS queries forwarded through the tunnel |

All outbound traffic is allowed (default AWS behaviour).

## IAM Role

Each gateway instance uses an IAM role with:

| Permission | Reason |
|---|---|
| `cloudformation:DescribeStackResource` | cfn-init reads stack metadata during bootstrap |
| `ec2:DescribeTags`, `ec2:DescribeInstances` | Instance self-identification |
| `AmazonEC2RoleforSSM` (managed policy) | SSM Session Manager access (no SSH needed) |

## Connectivity Analyzers

Two `AWS::EC2::NetworkInsightsPath` resources verify that each gateway instance can reach the Internet Gateway:

- `StrongSwanAZ1CanReachInternet`
- `StrongSwanAZ2CanReachInternet`

Run these analyses from the AWS Console (VPC → Network Manager → Reachability Analyzer) after deployment to confirm routing is correct before testing live BSP connectivity.

## Operational Notes

**Toggling the gateway off:** Set `StrongswanActive=false` on a stack update. This removes the EC2 instances, IAM resources, and conditional security group rules, but the ENIs and EIPs are not touched (they exist unconditionally).

**Updating PSK:** Update the `StrongswanPPPPSK` or `Strongswan3RDPSK` parameter and trigger a stack update. `cfn-hup` on each instance will detect the metadata change and re-run cfn-init to rewrite `ipsec.secrets` and restart the tunnels.

**Verifying tunnel status via SSM:**
```bash
sudo ipsec status            # connection/SA summary
sudo ipsec trafficstatus     # per-SA byte counters
ip -s link show vti0         # VTI interface counters
nft list ruleset             # confirm the masquerade rule loaded
```

**Re-applying nftables rules after reboot:** Rules are applied at bootstrap via cfn-init and persisted through the `nftables` service. If they are lost, re-run:
```bash
sudo nft -f /etc/nftables.conf
```

**AMI replacement:** To replace the gateway AMI, update `StrongswanAMI` in the stack. CloudFormation will terminate the old instances and launch new ones. The ENIs are pre-created separately from the instances, so the fixed IPs and EIP associations are preserved.
