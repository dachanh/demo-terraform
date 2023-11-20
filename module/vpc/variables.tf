variable "cidr" {
  description = "VPC cidr block"
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The name of the environment"
  type        = string
  default     = "stagging"
}

variable "vpc_name" {
  description = "name vpc"
}