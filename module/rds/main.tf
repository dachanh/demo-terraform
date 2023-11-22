resource "aws_db_instance" "amacho_database" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = var.rds_db_version
  instance_class       = var.instance_class
  username             = var.rds_username
  password             = var.rds_password
  parameter_group_name = "default.postgres13"
  deletion_protection  = false
  skip_final_snapshot  = true
  db_subnet_group_name = var.db_subnet_group_name

  vpc_security_group_ids = var.sg_private_ids
}