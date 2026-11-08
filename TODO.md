# ✅ InfraKit — TODO

Progress tracker for the build. Check items off as you go.

---

## 🏗️ Project Setup
- [x] Install Terraform + pin version via `.terraform-version` or `required_version`
- [ ] Set up AWS CLI credentials / profiles for dev and prod
- [x] Set up repo structure (`modules/`, `environments/`, `bootstrap/`)
- [ ] Configure `terraform fmt` + `terraform validate` in pre-commit hook
- [x] Set up CI to run `terraform validate` on PRs

## 🔒 Remote State Bootstrap
- [x] Write `bootstrap/state-backend` module (S3 bucket + DynamoDB table)
- [x] Enable S3 bucket versioning (state file history)
- [x] Enable S3 bucket encryption at rest
- [x] Block public access on the state bucket
- [x] Create DynamoDB table for state locking (`LockID` as partition key)
- [ ] Apply bootstrap module manually (one-time, before any environment)

## 🧩 Networking Module
- [x] Define VPC with configurable CIDR block
- [x] Create public + private subnets across multiple AZs
- [x] Create Internet Gateway (public subnets)
- [x] Create NAT Gateway (private subnet egress) — optional via `enable_nat_gateway`
- [x] Create route tables + associations
- [x] Output subnet IDs for consumption by other modules

## 🔐 Security Module
- [x] Define ALB security group (allow 443 from internet)
- [x] Define ECS security group (allow only from ALB SG)
- [x] Define RDS security group (allow only from ECS SG)
- [x] Define IAM roles for ECS task execution + task role
- [x] Review all policies for wildcard resources — eliminate them (S3 scoped in env layer; CW logs retain `*` for dynamic streams)

## 🖥️ Compute Module (`modules/ecs_alb`)
- [x] Define ECS cluster resource
- [x] Define ALB + target group + listener
- [x] Define ECS task definition (parameterized image tag)
- [x] Define ECS service (desired count, subnet placement)
- [x] Output ALB DNS name

## 🗄️ Data Module (`modules/rds`)
- [x] Define RDS subnet group (private subnets)
- [x] Define RDS instance (parameterized instance class)
- [x] Configure automated backups
- [x] Configure Multi-AZ for prod (toggle via variable)
- [x] Output RDS endpoint (marked sensitive)

## 📦 Storage Module (`modules/s3`)
- [x] Define S3 bucket for application storage
- [x] Configure bucket policy (block public access by default)
- [x] Configure lifecycle rules (e.g. archive/expire old objects)
- [x] Output bucket name/ARN

## 🌎 Environment Wiring
- [x] Write `environments/dev/main.tf` wiring all modules together
- [x] Write `environments/dev/dev.tfvars` (example: `dev.tfvars.example`)
- [x] Write `environments/dev` backend examples (`backend.tf.example` + `backend.hcl.example`)
- [x] Write `environments/prod/main.tf`
- [x] Write `environments/prod/prod.tfvars` (example: `prod.tfvars.example`)
- [x] Write `environments/prod` backend examples (`backend.tf.example` + `backend.hcl.example`)
- [x] Confirm dev + prod use shared modules under `modules/`

## 🧪 Testing & Validation
- [x] Run `terraform fmt` + `terraform validate` against dev, prod, and bootstrap (local Success 2026-11-08 via `%LOCALAPPDATA%\terraform` zip; CI uses setup-terraform 1.17.0)
- [ ] Run `terraform plan` against dev — review output carefully
- [ ] Run `terraform apply` against dev — verify resources in AWS console
- [ ] Test `terraform destroy` + re-`apply` for full reproducibility
- [ ] Test concurrent `apply` to confirm DynamoDB locking works
- [ ] Test `force-unlock` procedure on a deliberately stuck lock
- [ ] Validate security groups actually block unintended traffic

## 🚀 Rollout to Production
- [ ] Review `prod.tfvars` for correct instance sizes / scaling values
- [ ] Enable deletion protection on prod RDS
- [ ] Run `terraform plan -var-file="prod.tfvars"` and get it reviewed
- [ ] Apply to prod
- [x] Tag all resources consistently (environment, owner, project) — via `default_tags` + module tags

## 📄 Documentation
- [x] Write README.md with architecture diagrams
- [x] Document bootstrap procedure (`bootstrap/README.md`)
- [ ] Document each module's inputs/outputs (`terraform-docs`)
- [ ] Add CONTRIBUTING.md with PR/plan-review conventions

---

## 🗺️ Future / Roadmap (post-MVP)
- [ ] Add Terraform Cloud/Atlantis for automated plan-on-PR
- [ ] Add `terraform-compliance` or `checkov` for policy-as-code scanning
- [ ] Add a `staging` environment between dev and prod
- [ ] Migrate hardcoded values to a central `tfvars` schema with validation
- [ ] Add cost estimation via `infracost` in CI
- [ ] Add module versioning + a private Terraform module registry

---

*Last updated: 2026-11-08*
