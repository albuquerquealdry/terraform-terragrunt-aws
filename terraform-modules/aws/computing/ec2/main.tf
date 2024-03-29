module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]

  tags = var.tags
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.name

  ami                    = var.ami
  instance_type          = var.instance-type
  key_name               = var.pair
  monitoring             = var.monitoring
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_id              = var.subnet_id
  user_data              = var.user_data 
  tags = var.tags

  depends_on = [
    module.security_group
  ]
}
