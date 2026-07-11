# PhilPass BSP Gateway — CloudFormation Template

This stack provisions the AWS infrastructure required to connect PCHC to the **Bangko Sentral ng Pilipinas (BSP)** via the PhilPass Plus (PPP) payment gateway.

## Templates in this folder

| File | Scope |
|---|---|
| [`philpass.yaml`](philpass.yaml) | The **combined** stack — VPN gateway + DNS + Application (ALB, BSP Interface EC2) + Data (RDS). This README documents it. Its VPN resources still carry legacy `Strongswan*` names. |
| [`philpass-vpn.yaml`](philpass-vpn.yaml) | The **dedicated VPN-only** stack, split out of `philpass.yaml` so the LibreSwan gateway can be deployed and iterated independently (including in parallel with the combined stack during migration, and to a DR region). Uses `LibreSwan*` names. See **[LIBRESWAN.md](LIBRESWAN.md)** for its full reference. |

Both run the same LibreSwan-on-AL2023 gateway. Key differences in the dedicated `philpass-vpn.yaml`: `LibreSwan*` parameter names (`InstanceAmi`, `LibreSwanPPPPSK`, `LibreSwan3RDPSK`), **`t3.micro`** gateways with a 10 GiB gp3 root volume, **auto-assigned** ENI private IPs (registered with BSP post-deploy from stack outputs), no on/off toggle, and extra `BSPMode` values `ProductionDr`/`UATDr` for DR-region deployments.

## Architecture Overview

```
Internet
   │
   ├── EIP AZ1 ──► LibreSwan EC2 (AZ1) ──► IPsec tunnel ──► BSP PhilPassPlus
   ├── EIP AZ2 ──► LibreSwan EC2 (AZ2) ──► IPsec tunnel ──► BSP 3rd Party
   │
   └── ALB ──► BSP Interface EC2 ──► RDS MySQL
```

The stack is composed of four logical layers:

| Layer | Resources |
|---|---|
| VPN | LibreSwan EC2 instances on AL2023 (2× t3.nano in `philpass.yaml`; **t3.micro** in `philpass-vpn.yaml`, one per AZ), Elastic IPs, ENIs, route table entries |
| DNS | Route53 Resolver outbound endpoint forwarding `bsp.gov.ph` to BSP DNS servers |
| Application | BSP Interface EC2 (t3.medium), Application Load Balancer, Route53 A record |
| Data | RDS MySQL 8.4 (db.t4g.micro), AWS Backup (prod only) |

## Prerequisites

Before deploying this stack, the following stacks must already exist:

| Parameter | Description |
|---|---|
| `NetworkStackName` | Exports VPC ID, subnet IDs, route table IDs, jump host SG, internet gateway |
| `SNSStackName` | Exports SNS Topic ARN used by CloudWatch alarms |

Shared CloudFormation include files (mappings, conditions) are pulled from `s3://iscale-dev-cloudformation/include/`. Common nested stacks (loadbalancer, database, scheduler, backup) are pulled from `s3://iscale-dev-cloudformation/common/`.

## Parameters

### Resource Configuration

| Parameter | Default | Description |
|---|---|---|
| `Name` | `philpass` | Short identifier for resource naming (3–9 chars) |
| `OrgName` | `pchc` | Organization name, lowercase letters and hyphens only |
| `EnvName` | `Production` | Environment: `Production`, `Staging`, `Development`, or `Test` |

### Stack Configuration

| Parameter | Default | Description |
|---|---|---|
| `NetworkStackName` | `pchc-dev-ase1-network` | Name of the prerequisite network stack |
| `SNSStackName` | `pchc-dev-ase1-sns` | Name of the prerequisite SNS stack |
| `DeletionProtection` | `false` | Set `true` to enable termination protection on core resources (only effective in Production) |

### Load Balancer Configuration

| Parameter | Default | Description |
|---|---|---|
| `ClientDomainName` | `pchc.com.ph` | Client's domain name for the Route53 record |
| `LoadBalancerCertificateArn` | *(ACM ARN)* | ACM certificate ARN for HTTPS on the ALB |

### Instance Configuration

| Parameter | Default | Description |
|---|---|---|
| `BSPInterfaceAMI` | `ami-00b8d9cb8a7161e41` | AMI for the BSP Interface EC2 instance |
| `StrongswanAMI` | `ami-0499b5b9a26be1426` | AMI (Amazon Linux 2023) for the VPN gateway EC2 instances. Legacy-named; the gateway now runs LibreSwan |
| `InstanceKeyName` | *(empty)* | EC2 key pair name; omit to use SSM Session Manager only |
| `InstanceType` | `t3.medium` | Instance type for the BSP Interface server |

### Scheduler Configuration (non-prod only)

| Parameter | Default | Description |
|---|---|---|
| `StartScheduleExpression` | `cron(0 0 ? * MON-FRI *)` | CRON expression to start the RDS instance (UTC) |
| `StopScheduleExpression` | `cron(0 10 ? * MON-FRI *)` | CRON expression to stop the RDS instance (UTC) |

### BSP Interface Configuration

| Parameter | Default | Description |
|---|---|---|
| `StrongswanActive` | `true` | Set `false` to skip all VPN gateway resources (VPN, routes, DNS resolver). Legacy-named |
| `BSPMode` | `UAT` | BSP environment to connect to: `Production` or `UAT` |
| `BSPInterfaceHostname` | `philpassv2` | Hostname prefix for the Route53 record (e.g. `philpassv2.pchc.com.ph`) |
| `StrongswanPPPPSK` | *(sensitive)* | Pre-shared key for the PhilPassPlus IPsec tunnel |
| `Strongswan3RDPSK` | *(sensitive)* | Pre-shared key for the 3rd Party IPsec tunnel |

## BSP Mode Differences

| Feature | UAT | Production |
|---|---|---|
| PhilPassPlus tunnel | 1 resource IP | 6 resource IPs |
| Disaster Recovery tunnel | No | Yes (separate DR gateway) |
| 3rd Party tunnel | Yes | Yes |
| BSP DNS Resolver | No | Yes |
| Multi-AZ RDS | No | Yes |
| AWS Backup | No | Yes |
| CloudWatch Alarms | No | Yes |

> The dedicated `philpass-vpn.yaml` adds two more `BSPMode` values — **`ProductionDr`** and **`UATDr`** — for DR-region deployments. Each shares its family's remote config (same BSP endpoints/tunnels: `ProductionDr` behaves like `Production`, `UATDr` like `UAT`) and differs only in the **local** gateway subnet ranges. See [LIBRESWAN.md § BSP Modes](LIBRESWAN.md#bsp-modes).

## IPsec Tunnel Details

The gateway runs **LibreSwan on Amazon Linux 2023** using **route-based IPsec (VTI)** with **nftables** for SNAT. It is configured with IKEv1, PSK authentication, and the following cipher suites:

- **IKE**: `aes256-sha256-modp2048`, lifetime 43200s (12 hours)
- **ESP**: `aes128-sha256-modp2048`

Each tunnel is pinned to its own VTI interface (`vti0`/`vti1`/…) with a unique XFRM mark, and private-subnet traffic is masqueraded onto the VTI by a single nftables rule. This replaced the earlier StrongSwan-on-AL2 design (policy-based IPsec + iptables MASQUERADE on `eth0`), which stopped working on the AL2023 kernel 6.1 because the XFRM policy check now runs before POSTROUTING NAT. See [LIBRESWAN.md](LIBRESWAN.md) for the full gateway internals and the kernel rationale (and [STRONGSWAN.md](STRONGSWAN.md) for the legacy setup).

Each gateway instance attaches to a standalone ENI whose private IP is registered with BSP; the ENIs persist independently of the EC2 instances so the IPs survive instance replacement. In `philpass.yaml` the private IP is a fixed value from the mapping. In **`philpass-vpn.yaml` the private IP is auto-assigned** and the ENI is `DeletionPolicy: Retain` — you register it with BSP **after** deploy by reading the `LibreSwanAZ1PrivateIp` / `LibreSwanAZ2PrivateIp` outputs. Either way the IP must **not** change after registration.

The two Elastic IPs (`BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2`) have `DeletionPolicy: Retain`. Do not release them. BSP whitelists/routes by **both** the public IP **and** the local subnet (the tunnel's `leftsubnet`) — a new region's subnet must be registered too, or return traffic is dropped on BSP's side even though the tunnel comes up.

## Deployment

```bash
aws cloudformation deploy \
  --template-file philpass.yaml \
  --stack-name pchc-prd-ase1-philpass \
  --capabilities CAPABILITY_IAM \
  --parameter-overrides \
    EnvName=Production \
    BSPMode=Production \
    StrongswanActive=true \
    StrongswanPPPPSK=<secret> \
    Strongswan3RDPSK=<secret> \
    NetworkStackName=pchc-prd-ase1-network \
    SNSStackName=pchc-prd-ase1-sns \
    LoadBalancerCertificateArn=arn:aws:acm:...
```

### Dedicated VPN stack (`philpass-vpn.yaml`)

```bash
aws cloudformation deploy \
  --template-file philpass-vpn.yaml \
  --stack-name pchc-test-ase1-philpass-vpn \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    EnvName=Test \
    BSPMode=UATDr \
    InstanceAmi=ami-0499b5b9a26be1426 \
    LibreSwanPPPPSK=<secret> \
    LibreSwan3RDPSK=<secret> \
    NetworkStackName=<dr-region-network-stack> \
    SNSStackName=<sns-stack>
```

After deploy, read the outputs `LibreSwanAZ1PrivateIp`, `LibreSwanAZ2PrivateIp`, `BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2` and send all four to BSP for whitelisting. The gateway's in-guest `cfn-init` can OOM on the very first boot for small instances; if a tunnel never comes up, see [LIBRESWAN.md § Operational Notes](LIBRESWAN.md#operational-notes) for the manual `cfn-init` recovery.

## Monitoring

A CloudWatch Dashboard is created automatically, displaying:

- **Alarms panel** — all VPN gateway and BSP Interface alarms
- **CPU** — VPN gateway AZ1/AZ2, BSP Interface, RDS
- **Memory** — VPN gateway AZ1/AZ2, BSP Interface, RDS freeable memory
- **Performance** — ALB response time, RDS read/write latency
- **Network** — NetworkIn/Out for all instances
- **Space** — disk usage for VPN gateway and BSP Interface, RDS free storage

CloudWatch alarms (CPU ≥80%, memory ≥80%, disk ≥80%) are enabled only in Production and notify via the SNS topic from `SNSStackName`. The CloudWatch dashboard widgets label the gateway instances as `BSP-gateway-AZ1` / `BSP-gateway-AZ2`.

## Access

All instances are in private subnets with no public SSH exposure. Use **AWS Systems Manager Session Manager** (SSM) to access instances — no key pair is required unless `InstanceKeyName` is provided.

Database access from the jump host is explicitly allowed via a security group ingress rule using the jump host SG exported from the network stack.

## Notes

- The `ServerStack`, `CacheStack`, and `DeployStack` nested stacks are currently commented out. Uncomment and configure if an application server or ElastiCache cluster is needed.
- VPN gateway instances are sized for VPN tunnelling only: `t3.nano` in `philpass.yaml`, **`t3.micro`** in `philpass-vpn.yaml` (t3.nano's 512 MB OOM-kills `dnf` during package install on AL2023).
- The RDS scheduler (start/stop) is created only in non-production environments to reduce costs.
