output "globo_web_public_dns" {
  value       = aws_lb.nginx.dns_name
  description = "Public DNS of the AWS Instance"
}