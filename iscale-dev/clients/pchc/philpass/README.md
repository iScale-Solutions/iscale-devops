# PhilPass BSP Gateway — CloudFormation Template

This stack provisions the AWS infrastructure required to connect PCHC to the **Bangko Sentral ng Pilipinas (BSP)** via the PhilPass Plus (PPP) payment gateway.

## Architecture Overview

```
Internet
   │
   ├── EIP AZ1 ──► StrongSwan EC2 (AZ1) ──► IPsec tunnel ──► BSP PhilPassPlus
   ├── EIP AZ2 ──► StrongSwan EC2 (AZ2) ──► IPsec tunnel ──► BSP 3rd Party
   │
   └── ALB ──► BSP Interface EC2 ──► RDS MySQL
```

The stack is composed of four logical layers:

| Layer | Resources |
|---|---|
| VPN | StrongSwan EC2 instances (2× t3.nano, one per AZ), Elastic IPs, ENIs, route table entries |
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
| `StrongswanAMI` | `ami-0499b5b9a26be1426` | AMI for the StrongSwan VPN EC2 instances |
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
| `StrongswanActive` | `true` | Set `false` to skip all StrongSwan resources (VPN, routes, DNS resolver) |
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

## IPsec Tunnel Details

StrongSwan is configured with IKEv1, PSK authentication, and the following cipher suites:

- **IKE**: `aes256-sha256-modp2048`, lifetime 43200s (12 hours)
- **ESP**: `aes128-sha256-modp2048`

Each StrongSwan instance attaches to a pre-allocated ENI with a fixed private IP that is registered with BSP. These IPs must **not** change after registration — the ENIs persist independently of the EC2 instances.

The two Elastic IPs (`BSPVPNGatewayEIP1`, `BSPVPNGatewayEIP2`) have `DeletionPolicy: Retain` and must be registered with BSP before deployment. Do not release them.

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

## Monitoring

A CloudWatch Dashboard is created automatically, displaying:

- **Alarms panel** — all StrongSwan and BSP Interface alarms
- **CPU** — StrongSwan AZ1/AZ2, BSP Interface, RDS
- **Memory** — StrongSwan AZ1/AZ2, BSP Interface, RDS freeable memory
- **Performance** — ALB response time, RDS read/write latency
- **Network** — NetworkIn/Out for all instances
- **Space** — disk usage for StrongSwan and BSP Interface, RDS free storage

CloudWatch alarms (CPU ≥80%, memory ≥80%, disk ≥80%) are enabled only in Production and notify via the SNS topic from `SNSStackName`.

## Access

All instances are in private subnets with no public SSH exposure. Use **AWS Systems Manager Session Manager** (SSM) to access instances — no key pair is required unless `InstanceKeyName` is provided.

Database access from the jump host is explicitly allowed via a security group ingress rule using the jump host SG exported from the network stack.

## Notes

- The `ServerStack`, `CacheStack`, and `DeployStack` nested stacks are currently commented out. Uncomment and configure if an application server or ElastiCache cluster is needed.
- StrongSwan instances run as `t3.nano` and are not configurable — they are sized for VPN tunnelling only.
- The RDS scheduler (start/stop) is created only in non-production environments to reduce costs.
