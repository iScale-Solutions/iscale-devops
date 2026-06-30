# StrongSwan VPN Gateway — Setup Reference

> **⚠️ Legacy reference.** This document describes the original **StrongSwan on Amazon Linux 2** gateway (policy-based IPsec, iptables MASQUERADE on `eth0`, kernel 4.14/5.10). The gateway has since migrated to **LibreSwan on Amazon Linux 2023** (route-based VTI, nftables, kernel 6.1) — see **[LIBRESWAN.md](LIBRESWAN.md)** for the current setup and the kernel-6.1 rationale behind the change. This file is retained for historical reference of the legacy configuration.

This document describes how the StrongSwan IPsec VPN gateway is configured within the PhilPass stack. Two EC2 instances (one per Availability Zone) run StrongSwan to establish IPsec tunnels between PCHC's AWS VPC and the Bangko Sentral ng Pilipinas (BSP) network.

## Overview

```
PCHC VPC (private subnets)
        │
        ├── Route table AZ1 ──► StrongSwan ENI (AZ1, fixed private IP) ──► EIP1
        └── Route table AZ2 ──► StrongSwan ENI (AZ2, fixed private IP) ──► EIP2
                                        │
                           IPsec tunnels (IKEv1, PSK)
                                        │
                         ┌──────────────┼──────────────┐
                      PPP tunnel    PPP DR tunnel   3rd Party tunnel
                    (bspPPPlus)   (bspPPPlusDR)     (bspPP3rd)
                         │              │                │
                  121.127.5.157  121.127.17.175    121.127.5.50
```

StrongSwan acts as a **NAT-T gateway**: traffic from the private subnets is masqueraded (SNAT) to the StrongSwan instance's IP before entering the tunnel. `SourceDestCheck` is disabled on the ENIs to allow this.

## Fixed IPs and EIPs

The ENI private IPs and Elastic IPs are **registered with BSP** and must not change.

| Resource | Production | UAT |
|---|---|---|
| StrongSwan ENI private IP — AZ1 | `10.0.0.53` | `10.2.0.53` |
| StrongSwan ENI private IP — AZ2 | `10.0.0.176` | `10.2.0.176` |
| StrongSwan public subnet — AZ1 | `10.0.0.32/27` | `10.2.0.32/27` |
| StrongSwan public subnet — AZ2 | `10.0.0.160/27` | `10.2.0.160/27` |

The two Elastic IPs (`BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2`) are created with `DeletionPolicy: Retain`. They will survive stack deletion and must be pre-registered with BSP before the stack is first deployed. Do not release or reassign them.

## IPsec Tunnel Configuration

### Cipher Suites

All three tunnels use the same algorithms:

| Phase | Algorithm |
|---|---|
| IKE (Phase 1) | `aes256-sha256-modp2048` |
| ESP (Phase 2) | `aes128-sha256-modp2048` |
| Key exchange | IKEv1 |
| Authentication | Pre-shared key (PSK) |
| IKE lifetime | 43200s (12 hours) |

### Tunnels

#### `bspPPPlus` — PhilPassPlus Main

| Field | Production | UAT |
|---|---|---|
| Remote gateway (`right`) | `121.127.5.157` | `121.127.5.157` |
| Remote subnet (`rightsubnet`) | `192.168.80.0/24` | `192.168.222.0/24` |
| `forceencaps` | `yes` (AZ1), no (AZ2) | `yes` |
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

The left identity is always `@pchc`. This is written to `/etc/strongswan/ipsec.secrets` via cfn-init and is not stored in plaintext anywhere in the stack — the values come from the `StrongswanPPPPSK` and `Strongswan3RDPSK` CloudFormation parameters (`NoEcho: true`).

## NAT / iptables Rules

Each instance applies POSTROUTING MASQUERADE rules so that traffic from the private subnets appears to originate from the StrongSwan instance's IP when it enters the tunnel.

**Production AZ1 (`/etc/iptables.rules`):**
```
-A POSTROUTING -s 10.0.0.0/27  -d 192.168.4.0/24   -o eth0 -j MASQUERADE   # 3rd party
-A POSTROUTING -s 10.0.0.0/27  -d 192.168.80.0/24  -o eth0 -j MASQUERADE   # PPP
-A POSTROUTING -s 10.0.0.0/27  -d 192.168.90.0/24  -o eth0 -j MASQUERADE   # PPP DR
```

**UAT** omits the DR subnet. The private subnet CIDR in the source (`-s`) differs per AZ and per BSP mode.

Rules are applied at boot via:
```bash
/sbin/iptables-restore < /etc/iptables.rules
```

## Route Table Entries

Private route tables in both AZs get host routes for each BSP resource IP pointing at the StrongSwan ENI in the same AZ. These routes are conditional:

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
NetworkFiles → PSK → AZxConfig[Prod|UAT] → StartStrongSwan
```

### Step 1 — `NetworkFiles`

Enables IP forwarding and disables ICMP redirects on `eth0` (required for NAT routing):

```bash
echo 1 > /proc/sys/net/ipv4/ip_forward
echo 0 > /proc/sys/net/ipv4/conf/eth0/send_redirects
```

Also writes `/etc/sysctl.d/nat.conf` to persist across reboots.

### Step 2 — `PSK`

Writes `/etc/strongswan/ipsec.secrets` with the PSK entries for all three remote gateways.

### Step 3 — `AZxConfig[Prod|UAT]`

Writes two files:

- `/etc/iptables.rules` — NAT masquerade rules for this AZ and BSP mode
- `/etc/strongswan/ipsec.conf` — full tunnel configuration for this AZ and BSP mode

Both files are set to permissions `0700`, owned by `root`.

### Step 4 — `StartStrongSwan`

```bash
/usr/sbin/strongswan restart    # ignoreErrors: true
/sbin/iptables-restore < /etc/iptables.rules
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

Each StrongSwan instance uses an IAM role with:

| Permission | Reason |
|---|---|
| `cloudformation:DescribeStackResource` | cfn-init reads stack metadata during bootstrap |
| `ec2:DescribeTags`, `ec2:DescribeInstances` | Instance self-identification |
| `AmazonEC2RoleforSSM` (managed policy) | SSM Session Manager access (no SSH needed) |

## Connectivity Analyzers

Two `AWS::EC2::NetworkInsightsPath` resources verify that each StrongSwan instance can reach the Internet Gateway:

- `StrongSwanAZ1CanReachInternet`
- `StrongSwanAZ2CanReachInternet`

Run these analyses from the AWS Console (VPC → Network Manager → Reachability Analyzer) after deployment to confirm routing is correct before testing live BSP connectivity.

## Operational Notes

**Toggling StrongSwan off:** Set `StrongswanActive=false` on a stack update. This removes the EC2 instances, IAM resources, and conditional security group rules, but the ENIs and EIPs are not touched (they exist unconditionally).

**Updating PSK:** Update the `StrongswanPPPPSK` or `Strongswan3RDPSK` parameter and trigger a stack update. `cfn-hup` on each instance will detect the metadata change and re-run cfn-init to rewrite `ipsec.secrets` and restart StrongSwan.

**Verifying tunnel status via SSM:**
```bash
sudo strongswan statusall
```

**Re-applying iptables rules after reboot:** Rules are applied at bootstrap via UserData. If they are lost (unlikely), re-run:
```bash
sudo /sbin/iptables-restore < /etc/iptables.rules
```

**AMI replacement:** To replace the StrongSwan AMI, update `StrongswanAMI` in the stack. CloudFormation will terminate the old instances and launch new ones. The ENIs are pre-created separately from the instances, so the fixed IPs and EIP associations are preserved.
