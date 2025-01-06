# Valheim Dedicated Server Deployment with Terraform

This repository contains Terraform configurations to deploy an AWS EC2 instance running Ubuntu 20.04.6 LTS, configured as a Valheim dedicated server.

## Prerequisites

Before you begin, ensure you have the following:
- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS credentials with permissions to create EC2 instances.
- An existing SSH key pair to access the EC2 instance.

## Features
- Deploys an AWS EC2 instance with:
  - Ubuntu 20.04.6 LTS.
  - Instance type and other parameters configurable in `variables.tf` and `main.tf`.
- Generates a Valheim dedicated server setup script.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/<your-username>/valheim-terraform.git
   cd valheim-terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review and Adjust Variables**:
   Edit the `variables.tf` file to set your desired instance type, key pair name, and other configurations.

4. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   Confirm the changes when prompted. Terraform will output the public IP of the deployed instance.

5. **Access the Instance**:
   Use SSH to connect to the instance:
   ```bash
   ssh -i /path/to/your-key.pem ubuntu@<instance-public-ip>
   ```

6. **Start the Valheim Server**:
   Follow the instructions in the instance to start and manage the Valheim server.

## Cleanup

To destroy the deployed resources:
```bash
terraform destroy
```
Confirm the changes when prompted.

## Notes
- Ensure proper security group settings to allow connections to the Valheim server.
- Regularly back up your Valheim world data.
