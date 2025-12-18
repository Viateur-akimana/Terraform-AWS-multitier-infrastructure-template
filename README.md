# 3-Tier AWS Infrastructure with Terraform

## Project Overview
This project automates the deployment of a highly available, secure, 3-tier architecture on AWS using Terraform. The architecture is modularized, ensuring reusability and clean separation of concerns between networking, security, compute, and database layers.

## Architecture Layers

### 1. Presentation Layer (Public Tier)
- **Application Load Balancer (ALB):** Distributed across two public subnets in different Availability Zones (AZs). It acts as the entry point for all HTTP traffic.
- **Public Subnets:** Hosts the ALB and the NAT Gateway.

### 2. Application Layer (Private Tier)
- **Auto Scaling Group (ASG):** Automatically manages EC2 instances across two private application subnets.
- **Private App Subnets:** These subnets have no direct internet access. Outbound traffic is routed through a NAT Gateway for security.
- **Apache Web Server:** Installed via bootstrap scripts (User Data) to serve content.

### 3. Data Layer (Private Tier)
- **RDS MySQL Database:** A managed database instance residing in the private database subnets.
- **Private DB Subnets:** Isolated subnets with no internet access, accessible only from the application tier on port 3306.

---

## Project Structure
```text
3tier-project/
├── main.tf                 # Root configuration (calls all modules)
├── provider.tf             # AWS provider and Terraform version
├── outputs.tf              # High-level outputs (ALB DNS, DB Endpoint)
├── modules/
│   ├── networking/         # VPC, Subnets, IGW, NAT GW, Route Tables
│   ├── security/           # Tier-specific Security Groups
│   ├── alb/                # Application Load Balancer, Listeners, Target Groups
│   ├── compute/            # Launch Templates, Auto Scaling Group
│   └── database/           # RDS instances and Subnet Groups
```

---

## Implementation Details

### Networking
- **VPC CIDR:** 10.0.0.0/16
- **Multi-AZ:** Deployment across `eu-west-1a` and `eu-west-1b`.
- **Subnet breakdown:** 2 Public, 2 Private App, 2 Private DB subnets.
- **NAT Gateway:** Enables private instances to download packages without exposure.

### Security
- **Web Security Group:** Allows Port 80, 443, and ICMP from anywhere.
- **App Security Group:** Allows Port 80 and ICMP only from the Web SG.
- **DB Security Group:** Allows Port 3306 only from the App SG.

### Compute
- **Ubuntu 22.04:** AMI fetched dynamically via data sources.
- **Auto Scaling:** Minimum 2 instances, maximum 4.
- **Provisioning:** Automated installation of Apache via user_data.

---

## Deployment Instructions

### Prerequisites
- AWS CLI configured with appropriate credentials.
- Terraform (v1.6.0 or later) installed.

### Steps
1. **Initialize the project:**
   ```bash
   terraform init
   ```
2. **Review the execution plan:**
   ```bash
   terraform plan
   ```
3. **Deploy the infrastructure:**
   ```bash
   terraform apply
   ```
4. **Access the application:**
   Copy the `alb_dns_name` provided in the outputs and paste it into your browser.

---

## Tagging Convention
All resources are tagged for better organization and cost tracking:
- **Project:** 3tier-iac
- **Name:** Dynamic based on resource type
