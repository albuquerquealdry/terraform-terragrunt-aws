module "s3_terraform_state" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "terrform-state-ayo"
  acl    = "private"

  versioning = {
    enabled = true
  }
  # Bucket policies
  attach_policy                         = false
  # S3 bucket-level Public Access Block configuration
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  cors_rule = [
    {
      allowed_methods = ["PUT", "GET", "POST", "DELETE"]
      allowed_origins = ["*"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
      }, {
      allowed_methods = ["PUT", "GET", "POST", "DELETE"]
      allowed_origins = ["*"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]
}

terraform {
  backend "s3" {
    bucket   = "terrform-state-ayo"
    key      = "state/eks"
    region   = "eu-east-1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
