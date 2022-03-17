# Bucket object
output "web_bucket" {
  value       = aws_s3_bucket.web_bucket
  description = "Globo Web App S3 Bucket Object"
}

# Instance Profile object
output "instance_profile" {
  value       = aws_iam_instance_profile.nginx_profile
  description = "Globo Web App Instance Profile Object"
}