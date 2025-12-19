# 3-Tier AWS Architecture with Terraform

## 1. Project Overview
This project automates the deployment of a highly available, secure, 3-tier architecture on AWS using Terraform. The architecture is fully modularized, following best practices for reusability and separation of concerns.

### Architecture Layers:
1.  **Presentation Layer (Public Tier):**
    *   **Application Load Balancer (ALB):** Distributed across 2 Public Subnets in different AZs.
    *   **Bastion Host:** A jump server in the public subnet for secure administration.
2.  **Application Layer (Private Tier):**
    *   **Auto Scaling Group (ASG):** Automatically manages EC2 instances across 2 Private App Subnets.
    *   **Apache Web Server:** Provisioned via User Data script.
3.  **Data Layer (Private Tier):**
    *   **RDS MySQL:** A managed database instance in 2 Private DB Subnets, accessible only from the application tier.

---

## 2. Project Structure
```text
3tier-project/
├── main.tf                 # Root configuration (calls all modules)
├── variables.tf            # Root variables
├── outputs.tf              # Root outputs (ALB DNS, RDS endpoint, etc.)
├── provider.tf             # AWS provider configuration
├── terraform.tfvars        # User-defined variable values
├── modules/
│   ├── networking/         # VPC, Subnets, IGW, NAT GW, Route Tables
│   ├── security/           # Tier-specific Security Groups
│   ├── alb/                # ALB, Listeners, Target Groups
│   ├── compute/            # Launch Templates, ASG, Bastion Host
│   └── database/           # RDS instances and Subnet Groups
```

---

## 3. Module Descriptions

### Networking Module
*   Creates a VPC with a specified CIDR block.
*   Deploys 6 subnets: 2 Public, 2 Private App, 2 Private DB across 2 AZs.
*   Configures Internet Gateway and NAT Gateway for outbound connectivity.

### Security Module
*   **Web SG:** Allows HTTP/HTTPS and ICMP from anywhere.
*   **App SG:** Allows HTTP and ICMP from Web SG; SSH and ICMP from Bastion SG.
*   **Bastion SG:** Allows SSH from anywhere.
*   **DB SG:** Allows MySQL (3306) from App SG.

### ALB Module
*   Deploys an Application Load Balancer in public subnets.
*   Configures a Target Group and an HTTP Listener on Port 80.

### Compute Module
*   **Launch Template:** Uses a data source to fetch the latest Ubuntu AMI.
*   **ASG:** Scales between 2 and 4 instances.
*   **Bastion Host:** Provides a secure entry point to the private network.

### Database Module
*   Deploys an Amazon RDS MySQL instance.
*   Configures a DB Subnet Group across private DB subnets.

---

## 4. Deployment Instructions

### Prerequisites:
*   AWS CLI configured with credentials.
*   Terraform (v1.6.0+) installed.

### Steps:
1.  **Initialize:**
    ```bash
    terraform init
    ```
2.  **Configure Variables:**
    Edit `terraform.tfvars` with your specific values (Region, AZs, Key Name, etc.).
3.  **Plan:**
    ```bash
    terraform plan
    ```
4.  **Apply:**
    ```bash
    terraform apply
    ```
5.  **Verify:**
    Access the application using the `alb_dns` output.

---

## 5. Variables and Outputs

### Key Variables:
*   `region`: The AWS region to deploy to.
*   `owner`: Tag used for identifying resource ownership.
*   `db_password`: Secure password for the RDS instance.

### Root Outputs:
*   `alb_dns`: The DNS name of the Load Balancer.
*   `rds_endpoint`: The connection string for the database.
*   `asg_name`: The name of the Auto Scaling Group.
*   `bastion_public_ip`: Public IP to access the jump server.

---

## 6. Tagging Convention
All resources are tagged with:
*   **Project:** 3tier-app
*   **Environment:** dev
*   **Owner:** Viateur-akimana
*   **Name:** Unique name per resource
