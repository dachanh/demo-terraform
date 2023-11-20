# Module that allows creating a subnet inside a VPC. This module can be used to create
# either a private or public-facing subnet.

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.cidr_block, count.index)
  availability_zone = element(var.availability_zones, count.index)
  count             = length(var.cidr_block)

  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name        = "${var.name}-${var.environment}-${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

resource "aws_route_table" "subnet_route_table" {
  vpc_id = var.vpc_id
  count  = length(var.cidr_block)

  tags = {
    Name        = "${var.name}-${var.environment}${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "subnet_route_table_association" {
  subnet_id      = element(aws_subnet.subnet.*.id, count.index)
  route_table_id = element(aws_route_table.subnet_route_table.*.id, count.index)
  count          = length(var.cidr_block)
}