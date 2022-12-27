module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = "lab-21"
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    k8s = {
      min_size     = 1
      max_size     = 4
      desired_size = 3
      labels = {
        role = "general"
      }
      instance_types = ["t3.medium"]
    }
  }
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_role_access.iam_role_arn
      username = module.eks_role_access.iam_role_name
      groups   = ["system:masters"]
    }
  ]
}