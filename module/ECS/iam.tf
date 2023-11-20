data "aws_caller_identity" "current" {}

data "aws_region" "current" {
}

data "aws_iam_policy_document" "ecs_task_execution_document" {
  statement {
    effect  = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name   = "${var.name}-${var.environment}-policy"
  policy = data.aws_iam_policy_document.ecs_task_execution_document.json
}

resource "aws_iam_role" "ecs_task_execution_role" {

  name = "${var.name}-${var.environment}-ecs-task-execution"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })
  tags = {
    "environment" = var.environment
    "Name"        = "${var.environment}/ECSTaskExecution"
    "project"     = var.name
  }
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
  role       = aws_iam_role.ecs_task_execution_role.name
}

