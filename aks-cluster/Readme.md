# AKS Infrastructure with Terraform

Creates an Azure Kubernetes Service cluster with the supplied limits:

- Allowed agent-pool VM size: `Standard_D2s_v3`
- Maximum node pools: **1** (the default/system pool)
- Maximum node count in that pool: **2**
- Default node count: **1**
- System-assigned managed identity
- Azure RBAC integration enabled
- Resource tags for ownership and environment

## Prerequisites

- Azure CLI, Terraform >= 1.5, and an Azure subscription
- Azure permissions to create a resource group and AKS cluster

## Authenticate

```bash
az login
az account list --output table
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
az account show --query "{subscriptionId:id,name:name,tenantId:tenantId}" --output table
```

## Configure variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and replace the example `subscription_id` with your real subscription ID. Do not commit `terraform.tfvars`.

## Initialize, validate, plan, and deploy

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Review the plan before approving `terraform apply`.

## Connect to the cluster

```bash
az aks get-credentials   --resource-group rg-aks-terraform   --name aks-terraform-demo

kubectl get nodes
kubectl get namespaces
```

Change the names if you changed the variables.

## Destroy

This removes the resources managed by this configuration:

```bash
terraform destroy
```

## Notes

- Autoscaling is intentionally disabled; `node_count` is fixed and validated between 1 and 2. If autoscaling is later needed, configure the default pool with autoscaling enabled and min/max counts of 1 and 2.
- Azure region quota, VM availability, Azure Policy, and permissions can affect deployment.
- For production, review private-cluster access, networking, monitoring, upgrades, and remote Terraform state with restricted access and locking.
