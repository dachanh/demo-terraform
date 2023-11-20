resource "aws_ecr_repository" "ecr_repository" {
  name = "${var.name}-${var.environment}"
}

resource "aws_ecr_lifecycle_policy" "ecs_lifecycle" {
  count      = var.expiration_after_days > 0 ? 1 : 0
  repository = aws_ecr_repository.ecr_repository.name
  policy     = <<EOF
        {
            "rules": [
                {
                    "rulePriority": 1,
                    "description": "Expire images older than ${var.expiration_after_days} days",
                    "selection": {
                        "tagStatus": "any",
                        "countType": "sinceImagePushed",
                        "countUnit": "days",
                        "countNumber": ${var.expiration_after_days}
                    },
                    "action": {
                        "type": "expire"
                    }
                }
            ]
        }
    EOF
}