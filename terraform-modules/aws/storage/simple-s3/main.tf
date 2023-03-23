module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = var.acl
  attach_deny_insecure_transport_policy = var.tls
  versioning = {
    enabled = var.versioning
  }
}