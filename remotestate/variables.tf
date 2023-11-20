variable "bucket_name" {
  type        = string
  description = "bucket to use for remote tfstate"
}

variable "table_terraform_locks" {
  type = string
}

variable "region" {
  type = string
}


variable "account" {
  type = string
}

variable "name" {
  type = string
}

variable "aws_iam" {
  type = string
}