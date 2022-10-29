module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.23"
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets

  enable_irsa = true

  eks_managed_node_groups = {
    k8s = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size
      labels = {
        role = "general"
      }
      instance_types = var.instance_type
    }
  }
  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  aws_auth_roles = [
    {
      rolearn  = module.eks_admin_iam_role.iam_role_arn
      username = module.eks_admin_iam_role.iam_role_name
      groups   = ["system:masters"]
    }
  ]

}

data "aws_eks_cluster" "default"{
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

provider "kubernetes"{
  host = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args = ["eks","get-token","--cluster-name", data.aws_eks_cluster.default.id]
    command = "aws"
  }
}