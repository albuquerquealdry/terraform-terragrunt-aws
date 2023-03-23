variable "bucket_name" {
  type        = string
  description = "Nat Gateway"
  default     = "name"
}

variable "acl" {
  type        = string
  description = "ACL"
  default     = "public"
}

variable "tls" {
  type        = bool
  description = "Tags json"
  default     = false
}

variable "versioning" {
  type        = bool
  description = "Tags json"
  default     = false
}