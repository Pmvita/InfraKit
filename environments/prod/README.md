# Production environment

Same module graph as `environments/dev`, tuned for production defaults:

- NAT gateways enabled (one per AZ when `single_nat_gateway = false`)
- Multi-AZ RDS + deletion protection
- Higher ECS desired count / CPU / memory
- Distinct VPC CIDR (`10.10.0.0/16`) so it can coexist with dev in one account

## Usage

```bash
cp prod.tfvars.example prod.tfvars   # edit secrets — never commit
terraform init
terraform plan  -var-file=prod.tfvars
# After bootstrap: copy backend.tf.example → backend.tf and fill backend.hcl
# terraform init -backend-config=backend.hcl -migrate-state
```

Require a reviewed plan before `apply`. Prefer `TF_VAR_db_password` over committing passwords in tfvars.
