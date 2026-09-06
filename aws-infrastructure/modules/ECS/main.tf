resource "aws_cloudwatch_log_group" "url-shortener-logs" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = 7

  tags = {
    Name = "${var.project_name}-logs"
  }
}


resource "aws_ecs_cluster" "main-cluster" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.project_name}-cluster"
  }
}


resource "aws_ecs_task_definition" "url-shortener-task" {
  family                   = "${var.project_name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = var.task_cpu
  memory = var.task_memory

  execution_role_arn = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = var.container_image
      essential = true

      portMappings = [
        {
          name          = "${var.project_name}-port"
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.url-shortener-logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name = "${var.project_name}-task"
  }
}


resource "aws_ecs_service" "url-shortener-service" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main-cluster.id
  task_definition = aws_ecs_task_definition.url-shortener-task.arn

  desired_count = var.desired_count
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [var.subnet_id]

    security_groups = [
      var.security_group_id
    ]

    assign_public_ip = true
  }

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  tags = {
    Name = "${var.project_name}-service"
  }
}