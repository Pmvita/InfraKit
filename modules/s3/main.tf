resource "random_id" "suffix" {
  count       = var.bucket_suffix == "" ? 1 : 0
  byte_length = 4
}

locals {
  bucket_name = var.bucket_suffix != "" ? "${var.name_prefix}-app-${var.bucket_suffix}" : "${var.name_prefix}-app-${random_id.suffix[0].hex}"
}

resource "aws_s3_bucket" "this" {
  bucket        = local.bucket_name
  force_destroy = var.force_destroy

  tags = merge(var.tags, {
    Name = local.bucket_name
  })
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = var.lifecycle_expire_noncurrent_days > 0 || var.lifecycle_expire_days > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-and-cleanup"
    status = "Enabled"

    filter {
      prefix = ""
    }

    dynamic "noncurrent_version_expiration" {
      for_each = var.lifecycle_expire_noncurrent_days > 0 ? [1] : []
      content {
        noncurrent_days = var.lifecycle_expire_noncurrent_days
      }
    }

    dynamic "expiration" {
      for_each = var.lifecycle_expire_days > 0 ? [1] : []
      content {
        days = var.lifecycle_expire_days
      }
    }
  }
}
