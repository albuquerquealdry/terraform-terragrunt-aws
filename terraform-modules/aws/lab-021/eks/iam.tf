module "eks_policy_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "eks_policy_acess"

  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

module "eks_role_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name         = "eks_role_access"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.eks_policy_access.arn]

  trusted_role_arns = [
    "arn:aws:iam::687514835695:root"
  ]
  
  depends_on = [
    module.eks_policy_access
  ]

}