variable "name" {
  type    = string
  default = "vpn"
}

variable "cdr_block_vpc" {
  type    = string
  default = "10.1.0.0/16"
}

variable "azs" {
  type        = list(any)
  description = "Azs Lista"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets" {
  type        = list(any)
  description = "Subnet Private List"
  default     = ["10.1.1.0/24"]
}

variable "public_subnets" {
  type        = list(any)
  description = "Subnet Private List"
  default     = ["10.1.2.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Nat Gateway"
  default     = true
}

variable "enable_vpn_gateway" {
  type        = bool
  description = "Nat Gateway"
  default     = true
}

variable "tags" {
  type        = any
  description = "Tags json"
  default = {
    "project" : "teste"
  }
}