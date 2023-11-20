# output "nacl_db_private_ids" {
#   value = "${aws-aws_db_subnet_group.private_db.*.id}"
# }

output "db_subnet_group_name" {
  value = aws_db_subnet_group.private_db.name
}

output "sg_private_rds_ids" {
  value = aws_security_group.sg_private_rds[*].id
}

output "sg_private_ecs_ids" {
  value = aws_security_group.sg_ecs[*].id
}

output "public_subnet_ids" {
  value = module.public_subnet.ids
}

output "private_subnet_ids" {
  value = module.private_subnet.ids
}
