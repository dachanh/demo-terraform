variable "name_network" {
  type    = string
  default = "amacho"
}

variable "private_subnet_cidr_block" {
  type = list(any)
}

variable "public_subnet_cidr_block" {
  type = list(any)
}

variable "availability_zones" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Specify all traffic to be routed either trough Internet Gateway or NAT to access the internet"
}

variable "vpc_igw" {
  type = string
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}