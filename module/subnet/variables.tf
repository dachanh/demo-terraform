variable "name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west-1a"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Specify all traffic to be routed either trough Internet Gateway or NAT to access the internet"
}

variable "cidr_block" {
  type        = list(any)
  description = "List of cidrs, for every availability zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "availability_zones" {
  type        = list(any)
  description = "List of availability zones you want. Example: eu-west-1a and eu-west-1b"
}

variable "vpc_id" {
  description = "VPC id to place subnet into"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "the subnet is private or public"
}