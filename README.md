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
├── main.tf        # Resource group, client config data source, AKS cluster
├── providers.tf   # Terraform and AzureRM provider configuration
├── variables.tf   # Input variables
├── outputs.tf     # Output values
├── terraform.tfvars.example # Example variable values
└── Readme.md      # AKS-specific documentation
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.9.0
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) (optional, depending on auth)
- An active Azure subscription
- An SSH key pair for the VM administrator account

### Required Azure permissions

The identity running Terraform (locally, or the CI service principal) must be authorized in the target subscription. Otherwise `terraform apply` fails with `AuthorizationFailed` (for example, `Microsoft.Resources/subscriptions/resourceGroups/read`).

- Grant the identity the **Contributor** role at the subscription scope:

  ```bash
  az role assignment create \
    --assignee <service-principal-object-id> \
    --role "Contributor" \
    --scope "/subscriptions/<subscription-id>"
  ```

- The `azurerm` provider is configured with `resource_provider_registrations = "none"`, so the providers used by this configuration must be registered once in the subscription:

  ```bash
  for ns in Microsoft.ContainerService Microsoft.Network Microsoft.Compute Microsoft.ManagedIdentity; do
    az provider register --namespace "$ns"
  done
  ```

- Confirm the subscription configured here / in `AZURE_SUBSCRIPTION_ID` is the one where the role assignment was created.

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
   - `admin_ssh_public_key` - SSH public key for the administrator account (e.g. contents of `~/.ssh/id_ed25519.pub`)
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

- SSH access is restricted to the CIDR specified in `allowed_ssh_cidr`; password authentication is disabled and only the configured `admin_ssh_public_key` is accepted.
- The VM uses a system-assigned managed identity, encryption at host, secure boot, vTPM, and platform-managed patching.
- Public IP is static with a Standard SKU.
- State is stored locally by default; consider using remote backend for production use.

## AKS cluster

The `aks-cluster/` folder provisions an AKS cluster with a single system node pool (`Standard_D2s_v3`, 1–2 nodes), a system-assigned managed identity, Azure RBAC integration with local accounts disabled, API server access restricted to trusted IP ranges (`authorized_ip_ranges`), and Azure network policy enforcement.

```bash
cd Azure_Infra_Terraform/aks-cluster
terraform init
terraform plan
terraform apply
```
