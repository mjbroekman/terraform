billing_code = "ACCT123456"
project      = "Terraform-WebApp"
vpc_netblock = {
  Development = "10.0.0.0/16"
  UAT         = "10.1.0.0/16"
  Production  = "10.2.0.0/16"
}
vpc_subnet_count = {
  Development = 2
  UAT         = 2
  Production  = 3
}

instance_count = {
  Development = 2
  UAT         = 4
  Production  = 6
}

aws_inst_type = {
  Development = "t2.micro"
  UAT         = "t2.small"
  Production  = "t2.medium"
}