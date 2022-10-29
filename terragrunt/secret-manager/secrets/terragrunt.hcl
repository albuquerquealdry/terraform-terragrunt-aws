terraform {
  source = "../../../terraform-modules/aws/secret-manager"
}

dependency "role" {
  config_path = "../role"
}
inputs = {
    secrets = {
    "secret-kv-11" = {
      description = "This is a key/value secret"
      secret_key_value = {
        key1 = "value1"
        key2 = "value2"
      }
      recovery_window_in_days = 7
      policy                  = <<POLICY
				{
					"Version": "2012-10-17",
					"Statement": [
						{
							"Sid": "EnableAllPermissions",
							"Effect": "Allow",
							"Principal": {
								"AWS": "*"
							},
							"Action": "secretsmanager:GetSecretValue",
							"Resource": "*"
						}
					]
				}
				POLICY
    },
    "secret-kv-22" = {
      description = "Another key/value secret"
      secret_key_value = {
        username = "user"
        password = "topsecret"
      }
      tags = {
        app = "web"
      }
      recovery_window_in_days = 7
      policy                  = null
    },
  }
}