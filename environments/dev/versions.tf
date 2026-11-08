terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Default: local state (works for fmt/validate without bootstrap).
  # For remote state: copy backend.tf.example → backend.tf, fill backend.hcl, then
  #   terraform init -backend-config=backend.hcl -migrate-state
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "InfraKit"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
