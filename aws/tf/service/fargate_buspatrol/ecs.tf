data "aws_region" "current" {}

resource "aws_ecs_cluster" "buspatrol" {
  name = "buspatrol-cluster"

  tags = {
    Name = "buspatrol-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "buspatrol" {
  cluster_name = aws_ecs_cluster.buspatrol.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

# Service ECS resources
resource "aws_ecs_service" "buspatrol" {
  name            = "buspatrol-service"
  cluster         = aws_ecs_cluster.buspatrol.arn
  task_definition = aws_ecs_task_definition.buspatrol.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = module.vpc.private_subnet_ids
#    security_groups  = [aws_security_group.pulp_ecs.id]
#    assign_public_ip = false
  }

#  load_balancer {
#    target_group_arn = aws_lb_target_group.content.arn
#    container_name   = "pulp-content"
#    container_port   = var.content_port
#  }

  tags = {
    Name = "buspatrol-service"
  }
}


resource "aws_ecs_task_definition" "buspatrol" {
  family                   = "bus-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.resource_requirements.bus_task.cpu
  memory                   = var.resource_requirements.bus_task.memory
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  container_definitions = jsonencode([
    {
      "name" : "buspatrol-python"
      "image" : "756717229274.dkr.ecr.us-west-2.amazonaws.com/buspatrol"
      "cpu" : var.resource_requirements.bus_task.cpu
      "memory" : var.resource_requirements.bus_task.memory
      "essential" : true
      "logConfiguration" : {
        "logDriver" : "awslogs",
        "options" : {
          "awslogs-group" : aws_cloudwatch_log_group.ecs_log_group.name,
          "awslogs-region" : data.aws_region.current.name,
          "awslogs-stream-prefix" : "buspatrol-container"
        }
      }
    }
  ])

  ephemeral_storage {
    size_in_gib = 200
  }

  tags = {
    Name = "buspatrol-task"
  }
}