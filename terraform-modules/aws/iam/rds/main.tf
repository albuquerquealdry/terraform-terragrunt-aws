module "iam_assumable_roles" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"

  create_role = true

  role_name = "ayo-${var.name}-policy"
  custom_role_policy_arns  = [module.iam_policy.arn]
  role_requires_mfa = false

  depends_on = [
    module.iam_policy
  ]
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "example"
  path        = "/"
  description = "My example policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}