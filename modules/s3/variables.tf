variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "bucket_suffix" {
  description = "Optional unique suffix (AWS bucket names are globally unique). Leave empty to use random_id."
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "Allow terraform destroy to delete non-empty bucket (dev only)"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Enable S3 versioning"
  type        = bool
  default     = true
}

variable "lifecycle_expire_noncurrent_days" {
  description = "Expire noncurrent object versions after N days (0 disables)"
  type        = number
  default     = 90
}

variable "lifecycle_expire_days" {
  description = "Expire current objects after N days (0 disables)"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags applied to the bucket"
  type        = map(string)
  default     = {}
}
