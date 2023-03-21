variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = ""
}

variable "name" {
  type        = string
  description = "Name EC2"
  default     = ""
}

variable "region" {
  type        = string
  description = "Your Region"
  default     = ""
}

variable "ami" {
  type        = string
  description = "Your Ami"
  default     = "t2.micro"
}

variable "instance-type" {
  type        = string
  description = "Your Instance Type"
  default     = "t2.micro"
}

variable "pair" {
  type        = string
  description = "Your Pair"
  default     = "t2.micro"
}

variable "monitoring" {
  type        = bool
  description = "Monitoring"
  default     = false
}

variable "subnet_id" {
  type        = string
  description = " Subnet Id"
  default     = "Subnet Id"
}


variable "tags" {
  type        = any
  description = "Tags json"
  default = {
    "project" : "teste"

  }
}