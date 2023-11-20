variable "sg_private_ecs_ids" {
  type = list(any)
}

variable "public_subnet_ids" {
  type = list(any)
}

variable "name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west-1a"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}


variable "image_id" {
  type = string
}

variable "ecs_instance_type" {
  type = string
}

variable "private_subnet_ids" {
  type = list(any)
}

variable "api_address" {
  type    = number
  default = 80
}

variable "aws_region" {
  type = string
}

