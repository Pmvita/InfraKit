output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.networking.private_subnet_ids
}

output "alb_dns_name" {
  description = "Hit this hostname after apply (HTTP :80)"
  value       = module.ecs_alb.alb_dns_name
}

output "ecs_cluster_name" {
  value = module.ecs_alb.cluster_name
}

output "rds_endpoint" {
  value     = module.rds.endpoint
  sensitive = true
}

output "s3_bucket_name" {
  value = module.s3.bucket_id
}
