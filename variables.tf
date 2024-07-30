variable "common_name" {
  description = "The common prefix for all S3 bucket names"
  type        = string
  default     = "randomnamefsl"
}

variable "env" {
  description = "List of environments for which to create S3 buckets"
  type        = string
}
