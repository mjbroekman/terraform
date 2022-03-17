variable "naming_prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "globoweb"
}

variable "aws_region" {
  type        = string
  description = "AWS Deployment Region"
  sensitive   = false
  default     = "us-east-1"
}

variable "aws_ssm_ami_name" {
  type        = string
  description = "AWS SSM AMI Parameter name"
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "vpc_netblock" {
  type        = map(string)
  description = "VPC CIDR Block"
}

variable "vpc_subnet_count" {
  type        = map(number)
  description = "Number of subnets to create"
}

variable "vpc_enable_hostnames" {
  type        = bool
  description = "Enable VPC DNS Hostnames"
  default     = true
}

variable "aws_subnet_mapip" {
  type        = bool
  description = "Map AWS Public IP on launch"
  default     = true
}

variable "aws_vpc_def_route" {
  type        = string
  description = "Default route for VPC"
  default     = "0.0.0.0/0"
}

variable "nginx_secgroup" {
  description = "Security Group Definition for NGINX"
  type = object({
    name = string
    ingress = object({
      from  = number
      to    = number
      proto = string
      cidr  = list(string)
    })
    egress = object({
      from  = number
      to    = number
      proto = string
      cidr  = list(string)
    })
  })
  default = {
    name = "nginx_sg"
    ingress = {
      from  = 80
      to    = 80
      proto = "tcp"
      cidr  = ["0.0.0.0/0"]
    }
    egress = {
      from  = 0
      to    = 0
      proto = "-1"
      cidr  = ["0.0.0.0/0"]
    }
  }
}

variable "instance_count" {
  type        = map(number)
  description = "Number of EC2 instances to create"
}

variable "aws_inst_type" {
  type        = map(string)
  description = "Type of Instance to launch"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "Globomantics"
}

variable "project" {
  type        = string
  description = "Project name for resource tagging"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}
