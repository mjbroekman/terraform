##################################################################################
# DATA
##################################################################################
data "aws_ssm_parameter" "ami" {
  name = var.aws_ssm_ami_name
}

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################

# NETWORKING #

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3"

  cidr = var.vpc_netblock[terraform.workspace]

  azs            = slice(data.aws_availability_zones.available.names, 0, (var.vpc_subnet_count[terraform.workspace]))
  public_subnets = [for i in range(var.vpc_subnet_count[terraform.workspace]) : cidrsubnet(var.vpc_netblock[terraform.workspace], 8, i)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-vpc" })
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "${local.name_prefix}-nginx_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_netblock[terraform.workspace]]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-nginx-sg" })

}

resource "aws_security_group" "alb-sg" {
  name   = "${local.name_prefix}-nginx_alb_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-alb-sg" })

}
