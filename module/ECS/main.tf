resource "aws_ecs_cluster" "cluster" {
  name = "${var.name}-${var.environment}-cluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# Make cloudwatch log group
resource "aws_cloudwatch_log_group" "ecs_log" {
  name = "${var.name}-${var.environment}-ecs-task-log"
  tags = {
    "environment" = var.environment
    "Name"        = "${var.name}-cloudwatch-log-group-for-live-listening-event-consumer"
    "project"     = var.name
  }
}

# ECS Task Definition
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "${var.name}-${var.environment}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode([
    {
      "name" : "nginx-container",
      "image" : "nginx:latest",
      "portMappings" : [
        {
          "containerPort" : var.api_address,
          "hostPort" : var.api_address,
          "protocol" : "tcp"
        }
      ],
      "memory" : 512, // Specify the memory requirement for the container
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : "${aws_cloudwatch_log_group.ecs_log.id}",
          "awslogs-region" : "${var.aws_region}",
          "awslogs-create-group" : "true",
          "awslogs-stream-prefix" : "ecs"
        }
      }
    },
  ])

}

# ECS service 

resource "aws_ecs_service" "service" {
  name            = "${var.name}-${var.environment}-svc"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1

  enable_ecs_managed_tags = true
  network_configuration {
    subnets         = var.private_subnet_ids
    security_groups = var.sg_private_ecs_ids
  }
}
