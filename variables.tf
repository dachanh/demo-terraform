variable "environment" {
  description = "the enviroment's name"
}

variable "vpc_name" {
  description = "name vpc"
}

variable "vpc_cidr" {
  description = "VPC cidr block"
  default     = "10.0.0.0/16"
}

variable "aws_region" {
  description = "The AWS region to create resources in."
}

variable "access_key" {
  description = "The access key of IAM"
  type        = string
}

variable "secret_key" {
  description = "The secret key of IAM"
  type        = string
}

variable "availability_zones" {
  description = "availability_zones"
  type        = list(any)
}

variable "public_subnet_cidr_block" {
  type = list(any)
}

variable "private_subnet_cidr_block" {
  type = list(any)
}

variable "name" {
  type    = string
  default = "amacho"
}

variable "rds_instance_class" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_database" {
  type = string
}

variable "rds_db_version" {
  type = string
}

variable "image_id" {
  type = string
}

variable "ecs_instance_type" {
  type = string
}