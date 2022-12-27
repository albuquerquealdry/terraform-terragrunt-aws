module "allow_eks_access_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "allow-acess-eks"

  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

module "eks_admin_iam_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name         = "eks-admin"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.allow_eks_access_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]

}

module "allow_assume_eks_admin_iam_policy" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "allow-assume-admin-policy-eks"

  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect   = "Allow"
        Resource = "${module.eks_admin_iam_role.iam_role_arn}"
      }
    ]
  })
}

module "eks_admins_iam_group" {
  source                            = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  name                              = "eks-admin"
  attach_iam_self_management_policy = false
  create_group                      = true
  group_users                       = [*]
}