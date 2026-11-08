locals {
  tags = {
    Environment = var.environment
  }
}

module "networking" {
  source = "../../modules/networking"

  name_prefix        = var.name_prefix
  vpc_cidr           = var.vpc_cidr
  az_count           = var.az_count
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = false
  tags               = local.tags
}

module "security" {
  source = "../../modules/security"

  name_prefix = var.name_prefix
  vpc_id      = module.networking.vpc_id
  app_port    = var.app_port
  tags        = local.tags
}

module "ecs_alb" {
  source = "../../modules/ecs_alb"

  name_prefix           = var.name_prefix
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  private_subnet_ids    = module.networking.private_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
  ecs_security_group_id = module.security.ecs_security_group_id
  execution_role_arn    = module.security.ecs_execution_role_arn
  task_role_arn         = module.security.ecs_task_role_arn
  container_image       = var.container_image
  container_port        = var.app_port
  desired_count         = var.ecs_desired_count
  cpu                   = var.ecs_cpu
  memory                = var.ecs_memory
  tags                  = local.tags
}

module "rds" {
  source = "../../modules/rds"

  name_prefix           = var.name_prefix
  private_subnet_ids    = module.networking.private_subnet_ids
  security_group_ids    = [module.security.rds_security_group_id]
  instance_class        = var.db_instance_class
  db_name               = var.db_name
  username              = var.db_username
  password              = var.db_password
  multi_az              = var.db_multi_az
  deletion_protection   = var.db_deletion_protection
  skip_final_snapshot   = false
  backup_retention_days = 14
  tags                  = local.tags
}

module "s3" {
  source = "../../modules/s3"

  name_prefix   = var.name_prefix
  force_destroy = var.s3_force_destroy
  tags          = local.tags
}

# Scope ECS task role to this environment's app bucket (no wildcard * on S3)
data "aws_iam_policy_document" "ecs_s3" {
  statement {
    sid    = "AppBucketObjectAccess"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      module.s3.bucket_arn,
      "${module.s3.bucket_arn}/*",
    ]
  }
}

resource "aws_iam_role_policy" "ecs_s3" {
  name   = "${var.name_prefix}-ecs-s3"
  role   = module.security.ecs_task_role_name
  policy = data.aws_iam_policy_document.ecs_s3.json
}
