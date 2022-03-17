# INSTANCES #
resource "aws_instance" "web_servers" {
  count = var.instance_count[terraform.workspace]

  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.aws_inst_type[terraform.workspace]
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = module.web_app_s3.instance_profile.name
  depends_on             = [module.web_app_s3]
  user_data              = templatefile("${path.module}/startup_script.tpl", { s3_bucket_name = module.web_app_s3.web_bucket.id })

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-web_server-${count.index}" })


}
