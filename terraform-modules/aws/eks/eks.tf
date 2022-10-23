module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    k8s = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types = var.instance_type
    }
  }
}