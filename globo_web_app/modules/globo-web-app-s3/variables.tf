# Bucket Name
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

# ELB Service Account ARN
variable "elb_service_account_arn" {
  type        = string
  description = "ARN of ELB service account"
}

# Common Tags
variable "common_tags" {
  type        = map(string)
  description = "Common Tags"
  default     = {}
}