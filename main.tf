provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}


module "vpc" {
  source      = "./module/vpc"
  cidr        = var.vpc_cidr
  vpc_name    = var.vpc_name
  environment = var.environment
}

module "api_gateway" {
  source = "./module/api_gateway"
  vpc_id                    = module.vpc.vpc_id
}


module "network" {
  source                    = "./module/network"
  name_network              = var.name
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  availability_zones        = var.availability_zones
  vpc_igw                   = module.vpc.igw
}

module "ecr" {
  source                = "./module/ECR"
  name                  = var.rds_database
  environment           = var.environment
  expiration_after_days = 2
}

module "rds_instance" {
  source               = "./module/rds"
  name                 = var.rds_database
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.network.db_subnet_group_name
  rds_username         = var.rds_username
  rds_password         = var.rds_password
  rds_db_version       = var.rds_db_version
  instance_class       = var.rds_instance_class
  sg_private_ids       = module.network.sg_private_rds_ids
}

module "ecs" {
  source             = "./module/ECS"
  sg_private_ecs_ids = module.network.sg_private_ecs_ids
  public_subnet_ids  = module.network.public_subnet_ids
  name               = var.name
  aws_region         = var.aws_region
  environment        = var.environment
  image_id           = var.image_id
  ecs_instance_type  = var.ecs_instance_type
  private_subnet_ids = module.network.private_subnet_ids
}

# module "s3" {
#     source = "./module/s3"
#     name= var.name
#     environment = var.environment
# }


# module "cloudfront" {
#     source = "./module/cloudfront"
#     s3_bucket_domain = module.s3.s3_bucket_domain
# }
