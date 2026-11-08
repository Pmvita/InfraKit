# Bootstrap — Terraform remote state

Creates the **S3 bucket** (versioned, encrypted, public access blocked) and **DynamoDB lock table** that environment backends expect.

## When to apply

This is a **one-time** step per AWS account. Demo clones can leave it un-applied: environments still validate with a local backend until you wire remote state.

## Steps

```bash
cd bootstrap/state-backend
cp terraform.tfvars.example terraform.tfvars
# Edit state_bucket_name to a globally unique value

terraform init
terraform plan
terraform apply
```

Copy the `backend_hcl_snippet` output into `environments/dev/backend.hcl` (and prod when ready), then:

```bash
cd ../../environments/dev
terraform init -backend-config=backend.hcl -migrate-state
```

## Do not destroy casually

Destroying the state bucket without migrating state elsewhere loses the source of truth for all environments.
