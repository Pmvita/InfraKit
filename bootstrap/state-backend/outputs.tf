output "state_bucket_name" {
  description = "S3 bucket for Terraform state — use in environments/*/backend.hcl"
  value       = aws_s3_bucket.state.id
}

output "state_bucket_arn" {
  description = "ARN of the state bucket"
  value       = aws_s3_bucket.state.arn
}

output "lock_table_name" {
  description = "DynamoDB lock table name"
  value       = aws_dynamodb_table.locks.name
}

output "backend_hcl_snippet" {
  description = "Copy into environments/*/backend.hcl after apply"
  value       = <<-EOT
    bucket         = "${aws_s3_bucket.state.id}"
    key            = "infrakit/ENV/terraform.tfstate"
    region         = "${var.aws_region}"
    dynamodb_table = "${aws_dynamodb_table.locks.name}"
    encrypt        = true
  EOT
}
