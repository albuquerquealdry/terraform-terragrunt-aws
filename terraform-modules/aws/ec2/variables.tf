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

variable "ami_id" {
  type        = string
  description = "Your Region"
  default     = "t2.micro"
}