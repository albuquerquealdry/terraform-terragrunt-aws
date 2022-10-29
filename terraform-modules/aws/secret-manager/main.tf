
resource "aws_secretsmanager_secret" "secret-manager" {
  for_each                = var.secrets
  name                    = lookup(each.value, "name_prefix", null) == null ? each.key : null
  description             = lookup(each.value, "description", null)
  kms_key_id              = module.kms.key_id 
  policy                  = lookup(each.value, "policy", null)
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "secret-key-value" {
  for_each      = { for key, value in var.secrets : key => value }
  secret_id     = each.key                                            
  secret_string = lookup(each.value, "secret_string", null) != null ? lookup(each.value, "secret_string") : (lookup(each.value, "secret_key_value", null) != null ? jsonencode(lookup(each.value, "secret_key_value", {})) : null)
  depends_on    = [aws_secretsmanager_secret.secret-manager]
}

module "kms" {
  source = "terraform-aws-modules/kms/aws"
  description = "EC2 AutoScaling key usage"
  key_usage   = "ENCRYPT_DECRYPT"
  key_administrators = ["*"]
  key_users          = ["*"]
  key_service_users  = ["*"]
  aliases = ["myinfra"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}