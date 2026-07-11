# LibreSwan VPN Gateway — Setup Reference (current)

> **✅ Current approach.** This document describes the VPN gateway as it runs today: **LibreSwan on Amazon Linux 2023** (kernel 6.1) using **route-based IPsec (VTI)** with **nftables** for SNAT. It supersedes the legacy **[STRONGSWAN.md](STRONGSWAN.md)** (StrongSwan on AL2, policy-based IPsec, iptables MASQUERADE on `eth0`), retained only for historical reference.
>
> This reference documents the **dedicated VPN stack, [`philpass-vpn.yaml`](philpass-vpn.yaml)**, which was split out of the combined `philpass.yaml` so the gateway can be deployed and iterated on independently (including in parallel with the existing stack during migration). All logical IDs and parameters here use the `LibreSwan*` name (e.g. `InstanceAmi`, `LibreSwanInstanceAZ1`, `LibreSwanPPPPSK`). The legacy combined `philpass.yaml` still carries the older `Strongswan*` names — those are names only; the engine is LibreSwan in both.

Two EC2 instances (one per Availability Zone) run LibreSwan to establish IPsec tunnels between PCHC's AWS VPC and the Bangko Sentral ng Pilipinas (BSP) network.

## Overview

```
PCHC VPC (private subnets)
        │
        ├── Route table AZ1 ──► Gateway ENI (AZ1, retained, registered IP) ──► EIP1
        └── Route table AZ2 ──► Gateway ENI (AZ2, retained, registered IP) ──► EIP2
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

## IPs and EIPs

The gateway's addresses are **registered with BSP** and must not change once registered. They live on standalone, retained resources so the instances can be replaced without losing them.

| Resource | Source | Notes |
|---|---|---|
| Gateway ENI private IP — AZ1/AZ2 | **Auto-assigned** by EC2 from the public subnet | ENI has `DeletionPolicy: Retain`; read from the `LibreSwanAZ1PrivateIp` / `LibreSwanAZ2PrivateIp` outputs after deploy |
| Gateway Elastic IP — AZ1/AZ2 | `BSPVPNGatewayEIP1` / `BSPVPNGatewayEIP2` | `DeletionPolicy: Retain`; read from the `BSPVPNGatewayEIP1` / `BSPVPNGatewayEIP2` outputs |

**Registration is post-deploy, not pre-registered.** Because private IPs are now auto-assigned, the procedure is: deploy → read the four output values (2 private + 2 public) → send them to BSP to whitelist. The private IP is stable across instance stop/start and instance replacement (it lives on the retained ENI); it only changes if the ENI resource itself is recreated. See **Operational Notes** for replacing instances without losing the IPs.

### Local subnet ranges (per BSP mode)

The IPsec `leftsubnet` (gateway public `/27`) and the nftables masquerade source (gateway private `/27`) come from the `BSPConfig` mapping, keyed by `BSPMode`:

| Mapping key | Feeds | Notes |
|---|---|---|
| `LibreSwanPublicSubnetAZ1/2` | `leftsubnet` in `ipsec.conf` | the ENI IP falls inside this `/27` |
| `LibreSwanPrivateSubnetAZ1/2` | nftables masquerade **source** set | private-instance traffic is SNATed to the ENI IP so it matches the SA |

These differ per region/mode. `Production`/`UAT` are the primary-region ranges; **`ProductionDr`/`UATDr`** carry the DR-region ranges (see **BSP Modes**).

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

| Config family | `bspPPPlus` | `bspPPPlusDR` | `bspPP3rd` |
|---|---|---|---|
| Production / ProductionDr (AZ1 & AZ2) | `vti0` / mark `42` | `vti1` / mark `43` | `vti2` / mark `44` |
| UAT / UATDr (AZ1 & AZ2) | `vti0` / mark `42` | *(not created)* | `vti1` / mark `43` |

### Tunnels

#### `bspPPPlus` — PhilPassPlus Main

| Field | Production | UAT |
|---|---|---|
| Remote gateway (`right`) | `121.127.5.157` | `121.127.5.157` |
| Remote subnet (`rightsubnet`) | `192.168.80.0/24` | `192.168.222.0/24` |
| PSK parameter | `LibreSwanPPPPSK` | `LibreSwanPPPPSK` |

#### `bspPPPlusDR` — PhilPassPlus Disaster Recovery (Production family only)

| Field | Value |
|---|---|
| Remote gateway (`right`) | `121.127.17.175` |
| Remote subnet (`rightsubnet`) | `192.168.90.0/24` |
| PSK parameter | `LibreSwanPPPPSK` (same key as main PPP) |

This tunnel is not created in the UAT family (`UAT`/`UATDr`).

#### `bspPP3rd` — 3rd Party

| Field | Production | UAT |
|---|---|---|
| Remote gateway (`right`) | `121.127.5.50` | `121.127.5.50` |
| Remote subnet (`rightsubnet`) | `192.168.4.0/24` | `192.168.222.0/24` |
| PSK parameter | `LibreSwan3RDPSK` | `LibreSwan3RDPSK` |

> The **remote** side (gateways, remote subnets, resources) is identical across a family's primary and DR modes — only the **local** subnet ranges differ. This is why the DR-only mapping keys (`PPPDRGateway`, `PPPDRSubnetCIDR`) stay pinned to `Production` in the config sets (see **BSP Modes**).

### `ipsec.secrets` format

```
@pchc <PPP_GATEWAY>    : PSK "<LibreSwanPPPPSK>"
@pchc <PPP_DR_GATEWAY> : PSK "<LibreSwanPPPPSK>"
@pchc <3RD_GATEWAY>    : PSK "<LibreSwan3RDPSK>"
```

The left identity is always `@pchc`. This is written to `/etc/ipsec.d/ipsec.secrets` (mode `0600`) via cfn-init. The values come from the `LibreSwanPPPPSK` and `LibreSwan3RDPSK` CloudFormation parameters (`NoEcho: true`).

> **Secret storage.** A copy of the PSKs is also stored in a Secrets Manager secret (`LibreSwanSecrets`) as a reference to hand-edit later. Note: because the PSKs are rendered into the launch template's `AWS::CloudFormation::Init` metadata, they are retrievable in plaintext via `cloudformation:DescribeStackResource` (AWS `NoEcho` does **not** mask metadata). Also note that a manual edit to the secret is overwritten on the next stack update whenever the `LibreSwanPPPPSK`/`LibreSwan3RDPSK` parameter values change.

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
- **One wildcard rule covers every tunnel.** Adding more tunnels/destinations adds no rules. The legacy iptables design needed one MASQUERADE rule per destination subnet because all tunnels shared `eth0`; with one VTI per tunnel the output interface already scopes the traffic.
- **`source_subnet` scoping is preserved** so only private-instance traffic is masqueraded — the gateway's own traffic is untouched.

Rules are applied at boot via:
```bash
nft -f /etc/nftables.conf && systemctl enable --now nftables
```

## BSP Modes

`BSPMode` selects which `BSPConfig` mapping block is used. There are two families — Production and UAT — each with a primary and a DR-region variant:

| `BSPMode` | Config set family | DR tunnel? | Local subnets |
|---|---|---|---|
| `Production` | Prod (3 tunnels) | yes | primary-region Production ranges |
| `ProductionDr` | Prod (3 tunnels) | yes | **DR-region** ranges |
| `UAT` | UAT (2 tunnels) | no | primary-region UAT ranges |
| `UATDr` | UAT (2 tunnels) | no | **DR-region** ranges |

The `IsBSPProd`/`IsBSPUAT` conditions are `!Or` of a family's two modes, so `ProductionDr` routes to the Prod config set and `UATDr` to the UAT config set. The config sets read mapping values by `!Ref BSPMode`, so each mode picks up its own local subnets.

**Important — `FindInMap` + eager evaluation.** `AWS::CloudFormation::Init` metadata (and both branches of any `Fn::If`) is resolved for the current `BSPMode` at deploy/change-set time, regardless of which config set an instance will actually run. Any `!FindInMap [BSPConfig, !Ref BSPMode, <key>]` therefore requires `<key>` to exist in **every** mapping `BSPMode` can resolve to. Keys that exist only in the Production family (`PPPDRGateway`, `PPPDRSubnetCIDR`, `PPPResource2–6`) must be pinned to a literal `Production` in the config-set metadata — using `!Ref BSPMode` for them fails a UAT/UATDr deploy with `Unable to get mapping for BSPConfig::UAT::PPPDRGateway`. Only keys present in all four mappings (local subnets, `PPPGateway`, `PP3rdParty*`) use `!Ref BSPMode`.

When adding a new region, fill the DR block's `LibreSwan*Subnet*` placeholders with that region's actual subnet CIDRs before deploying.

## Bootstrapping via cfn-init

Instance `UserData` calls `cfn-init` with one of four configSets. Selection is `!If [IsBSPUAT, AZ*ConfigUAT, AZ*ConfigProd]`, so DR modes map to their family's config set:

| ConfigSet | Used when |
|---|---|
| `AZ1ConfigProd` / `AZ2ConfigProd` | `BSPMode` in {`Production`, `ProductionDr`} |
| `AZ1ConfigUAT` / `AZ2ConfigUAT` | `BSPMode` in {`UAT`, `UATDr`} |

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

> On t3.nano (512 MB) this step OOM-kills `dnf makecache` (`return code -9`). The instances run **t3.micro** for this reason; if you ever run this on a smaller size, add swap before the install. See **Operational Notes**.

### Step 2 — `NetworkFiles`

Enables IP forwarding, disables redirects on `ens5` (AL2023 interface name), and applies a persisted sysctl hardening file:

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/ens5/send_redirects
sysctl --system
```

Writes `/etc/sysctl.d/99-ipsec-vpn.conf`, which persists `ip_forward`, disables accept/send redirects and source routing, sets `rp_filter=0` globally, and applies ICMP/ASLR hardening across reboots. (`StartLibreSwan` additionally sets `rp_filter=0` and `disable_policy=1` on the `vti*` interfaces after ipsec starts, since those devices don't exist at sysctl time.)

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
# 03_disable_rp_filter_vti: rp_filter=0 / disable_policy=1 on vti0, vti1 after ipsec is up
```

`cfn-hup` is also started to listen for stack metadata changes and re-run cfn-init when the stack is updated — **provided the initial bootstrap got far enough to start it.** If cfn-init fails early (the `set -e` script exits before the `cfn-hup` line), cfn-hup is not running and metadata-change re-triggers won't work; re-run cfn-init manually.

## Instance sizing & storage

- **Instance type: `t3.micro`.** t3.nano's 512 MB is insufficient for the AL2023 `dnf` cache build during `InstallPackages`.
- **Root volume: 10 GiB `gp3`, encrypted**, declared via `BlockDeviceMappings` (`/dev/xvda`, `DeleteOnTermination: true`). There is no separate data volume — the OS and everything else live on root.
- **Resizing root without replacement:** CloudFormation can't grow an instance's root in place cleanly. Use an out-of-band elastic resize — `aws ec2 modify-volume` → `growpart /dev/nvme0n1 1` → `xfs_growfs -d /` — then update `VolumeSize` in the template to match.

## Route Table Entries

Private route tables in both AZs get host routes for each BSP resource IP pointing at the gateway ENI in the same AZ:

| Route | Condition |
|---|---|
| `BSP3rdPartyRoute` / `PPPResource1Route` (AZ1 + AZ2) | always (gateway active) |
| `PPPResource2–6Routes` (AZ1 + AZ2) | `IsBSPProd` (Production family only) |
| `PPPDRResource1–4Routes` (AZ1 + AZ2) | `IsBSPProd` |
| `BSPPhilPassPlusDNS1/2Routes` (AZ1 + AZ2) | always |

> **These route resources are currently commented out in `philpass-vpn.yaml`.** During the migration/testing phase, routing is added and reverted manually so the parallel stack doesn't divert live traffic. Note a route table holds only one route per destination CIDR — you cannot add a parallel route for a BSP destination that the existing stack already routes; you'd be replacing it.

## Security Group

The `LibreSwanSecurityGroup` has no inbound rules by default. These ingress rules are added (unconditionally — there is no on/off toggle in this stack):

| Protocol | Port | Source | Purpose |
|---|---|---|---|
| ICMP | all | VPC CIDR | Ping/health checks from within VPC |
| TCP | 443 | VPC CIDR | HTTPS from BSP Interface and internal services |
| UDP | 53 | VPC CIDR | DNS queries forwarded through the tunnel |

All outbound traffic is allowed (default AWS behaviour).

## IAM Role

Each gateway instance uses `LibreSwanEC2Role` with:

| Permission | Reason |
|---|---|
| `cloudformation:DescribeStackResource` | cfn-init reads stack metadata during bootstrap |
| `ec2:DescribeTags`, `ec2:DescribeInstances` | Instance self-identification |
| `AmazonEC2RoleforSSM` (managed policy) | SSM Session Manager access (no SSH needed) |

The role name is CloudFormation-generated (no explicit `RoleName`). When running cfn-init manually, **omit `--role`** — passing the logical id `LibreSwanEC2Role` 404s because IMDS keys credentials by the generated role name; without `--role`, cfn-init uses the instance-profile credentials.

## Connectivity Analyzers

Two `AWS::EC2::NetworkInsightsPath` resources (`LibreSwanAZ1CanReachInternet`, `LibreSwanAZ2CanReachInternet`) verify each gateway can reach the Internet Gateway. **Currently commented out** alongside the routes/alarms during migration; uncomment and run from the AWS Console (VPC → Reachability Analyzer) when needed.

## Operational Notes

**Registering IPs with BSP:** After deploy, read the outputs `LibreSwanAZ1PrivateIp`, `LibreSwanAZ2PrivateIp`, `BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2` and send all four to BSP for whitelisting. BSP whitelists/routes by **both** the public IP **and** the local subnet (traffic selector) — see *DR return-path* below.

**Replacing instances without losing the registered IPs:** The IPs live on the retained ENIs (private) and retained EIPs (public), not the instances. To swap instances (e.g., after a failed bootstrap), either do the two-step CloudFormation swap — (1) comment out `LibreSwanInstanceAZ1/2` and update → old instances deleted, ENIs/EIPs keep their IPs; (2) uncomment and update → new instances re-attach the same ENIs — or terminate/relaunch out of band and re-attach the ENIs. **Do not delete the whole stack**: that orphans the retained ENIs/EIPs and a fresh deploy allocates new (unregistered) IPs. Never comment out the ENIs, EIPs, or EIP associations.

**Recovering a failed bootstrap (manual cfn-init):** The instances have no `CreationPolicy`, so a failed in-guest cfn-init does not fail the stack. To finish the setup on a running instance, SSM in and run (note: **no `--role`**):
```bash
# on t3.nano only — add swap first so dnf doesn't OOM:
sudo fallocate -l 1G /swapfile && sudo chmod 600 /swapfile
sudo mkswap /swapfile && sudo swapon /swapfile

sudo /usr/local/bin/cfn-init -v \
  --stack <stack-name> \
  --resource LibreSwanLaunchTemplate \
  -c AZ1ConfigUAT \
  --region <region>
```
Use the config set matching the instance's AZ and BSP-mode family (`AZ2ConfigUAT`, `AZ1ConfigProd`, …). UserData runs only on first boot, so a stop/start does **not** re-run it.

**Updating PSK:** Update `LibreSwanPPPPSK` or `LibreSwan3RDPSK` and trigger a stack update. If `cfn-hup` is running, it re-runs cfn-init to rewrite `ipsec.secrets` and restart the tunnels; otherwise re-run cfn-init manually.

**AMI replacement:** Update `InstanceAmi`. Note `ImageId`/`UserData` changes force instance **replacement** — because the instances reference standalone ENIs (which can't attach to two instances at once), prefer the two-step swap above over an in-place replacement.

**Verifying tunnel status via SSM:**
```bash
sudo ipsec status            # full connection/SA dump
sudo ipsec trafficstatus     # one line per established SA + byte counters (best quick check)
sudo ipsec showstates        # just the SA state lines
ip -s link show vti0         # per-VTI interface counters
nft list ruleset             # confirm the masquerade rule loaded
sudo journalctl -u ipsec -f  # live negotiation log
```

**DR return-path (a tunnel can be "up" but one-way):** A DR-mode tunnel can reach Phase 2 (`ESPout` climbing) yet `ESPin=0` and pings time out. This is almost always because BSP has a **return route only for the primary subnet**, not the DR local subnet — the same remote endpoint accepts your SA, but their internal routing has no path back to the new DR `/27`, so replies are dropped on their side. Fix: have BSP add a **route/whitelist for the DR local subnet** (the `leftsubnet` the SA advertises) pointing into this tunnel. Confirm one-way flow with `sudo tcpdump -ni vti0 icmp` (requests leave, no replies) and `ipsec trafficstatus` (`outBytes` grows, `inBytes` stays 0).
