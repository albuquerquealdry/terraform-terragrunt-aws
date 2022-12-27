module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-lab-21"
  cidr = "10.1.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets     = ["10.1.1.0/24","10.1.2.0/24" ]
  enable_nat_gateway = false
  single_nat_gateway     = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}

##########################
#### INTERNET GATEWAY ####
##########################
resource "aws_internet_gateway" "lab-21" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "lab-21-igw"
  }
  depends_on = [
    module.vpc
  ]
}