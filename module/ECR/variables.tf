variable "name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west-1a"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "expiration_after_days" {
  type = number
}