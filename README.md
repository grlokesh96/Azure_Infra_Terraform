# Azure Infrastructure Terraform (Linux VM)

This repository contains Terraform code to provision a secure Linux VM on Microsoft Azure.

## Structure

```text
azure-vm/
├── main.tf        # Resource group and locals
├── network.tf     # VNet, subnet
├── security.tf    # NSG, public IP, NIC, NSG association
├── vm.tf          # Linux VM configuration
├── provider.tf    # AzureRM provider
├── variables.tf   # Input variables
├── outputs.tf     # Output values
├── versions.tf    # Provider and Terraform version constraints
└── terraform.tfvars.example # Example variable values

aks-cluster/
├── main.tf        # Resource group
├── networking.tf  # VNet, subnets, NAT gateway
├── monitoring.tf  # Log Analytics workspace
├── aks.tf         # AKS cluster and node pools
├── acr.tf         # Azure Container Registry and AcrPull role assignment
├── providers.tf   # AzureRM provider
├── variables.tf   # Input variables
├── outputs.tf     # Output values
└── terraform.tfvars # Variable values
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.9.0
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) (optional, depending on auth)
- An active Azure subscription
- Administrator username and password for the VM

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/grlokesh96/Azure_Infra_Terraform.git
   cd Azure_Infra_Terraform/azure-vm
   ```

2. Copy and configure variables:

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

   Edit `terraform.tfvars` and provide:
   - `subscription_id` - Your Azure subscription ID
   - `admin_username`  - Linux administrator username
   - `admin_password`  - Linux administrator password (min 12 chars with upper, lower, digit and special character)
   - `allowed_ssh_cidr` - Your public IP/CIDR for SSH access (e.g., `1.2.3.4/32`)

3. Initialize Terraform:

   ```bash
   terraform init
   ```

4. Validate the configuration:

   ```bash
   terraform validate
   ```

5. Plan the deployment:

   ```bash
   terraform plan
   ```

6. Apply the deployment:

   ```bash
   terraform apply
   ```

7. Clean up:

   ```bash
   terraform destroy
   ```

## Notes

- SSH access is restricted to the CIDR specified in `allowed_ssh_cidr`; authentication uses the configured `admin_username`/`admin_password`.
- The VM uses a system-assigned managed identity, encryption at host, secure boot, vTPM, and platform-managed patching.
- Public IP is static with a Standard SKU.
- State is stored locally by default; consider using remote backend for production use.

## AKS cluster

The `aks-cluster/` folder provisions an AKS cluster with a system and user node pool, Azure CNI Overlay networking with a NAT gateway for egress, a Log Analytics workspace for Container Insights, and an Azure Container Registry with the `AcrPull` role assigned to the kubelet identity.

```bash
cd Azure_Infra_Terraform/aks-cluster
terraform init
terraform plan
terraform apply
```
