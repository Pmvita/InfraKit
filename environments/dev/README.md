# Dev environment

Wires modules: `networking` → `security` → `ecs_alb` + `rds` + `s3`.

## Validate (no AWS apply)

```bash
# Copy example vars (edit password)
cp dev.tfvars.example terraform.tfvars

# Local backend for fmt/validate without remote state:
terraform init -backend=false
terraform validate
terraform plan -var-file=terraform.tfvars   # needs AWS credentials
```

## Remote state (after bootstrap)

```bash
cp backend.hcl.example backend.hcl
# edit bucket / table names from bootstrap outputs
terraform init -backend-config=backend.hcl
terraform plan -var-file=terraform.tfvars
```

## Notes

- `enable_nat_gateway = false` by default to avoid NAT charges; ECS tasks in private subnets will not have internet egress until NAT is enabled.
- Never commit real `db_password` values.
