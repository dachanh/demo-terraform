variable "vpc_id" {
  type = string
}


variable "cidr_blocks" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "sg_private_ids" {
  type        = list(any)
  description = "security group private id"
}

variable "db_subnet_group_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "name" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "rds_db_version" {
  type = string
}