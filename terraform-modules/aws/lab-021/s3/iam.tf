module "policy-s3-terraform-state" {
  source = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name = "policy-s3-terraform-state"

  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

module "role-s3-terraform-state" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  role_name         = "role-s3-terraform-state"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.policy-s3-terraform-state.arn]

  trusted_role_arns = [
    "arn:aws:iam::043525666653:root"
  ]
  
  depends_on = [
    module.policy-s3-terraform-state
  ]
}