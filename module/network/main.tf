
module "private_subnet" {
  source                  = "../subnet"
  name                    = "${var.name_network}-private-subnet"
  vpc_id                  = var.vpc_id
  environment             = var.environment
  map_public_ip_on_launch = false
  availability_zones      = var.availability_zones
  cidr_block              = var.private_subnet_cidr_block
}

module "public_subnet" {
  source                  = "../subnet"
  name                    = "${var.name_network}-public-subnet"
  vpc_id                  = var.vpc_id
  environment             = var.environment
  map_public_ip_on_launch = true
  availability_zones      = var.availability_zones
  cidr_block              = var.public_subnet_cidr_block
}

module "nat" {
  source           = "../nat_gateway" // NAT gateway
  subnet_ids       = module.public_subnet.ids
  subnet_count     = length(var.public_subnet_cidr_block)
  internet_gateway = var.vpc_igw
}

resource "aws_route" "public_igw_route" {
  count                  = length(var.public_subnet_cidr_block)
  route_table_id         = element(module.public_subnet.route_table_ids, count.index)
  gateway_id             = var.vpc_igw
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_route" "private_nat_route" {
  count                  = length(var.private_subnet_cidr_block)
  route_table_id         = element(module.private_subnet.route_table_ids, count.index)
  nat_gateway_id         = element(module.nat.ids, count.index)
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_security_group" "sg_ecs" {
  name   = "${var.name_network}-${var.environment}-ecs-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// make security group  for rds
resource "aws_security_group" "sg_private_rds" {
  name   = "${var.name_network}-${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.sg_ecs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


//groups private subnets for database instances 
resource "aws_db_subnet_group" "private_db" {
  name       = "${var.name_network}-${var.environment}-db-subnet"
  subnet_ids = module.private_subnet.ids
}

