variable "subnet_ids" {
  type        = list(any)
  description = "list of subnets id"
}

variable "subnet_count" {
  description = "size of the subnet_ids list"
}

variable "internet_gateway" {
  type = string
}