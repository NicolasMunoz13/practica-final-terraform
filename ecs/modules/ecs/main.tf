/*resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.dns_hostnames
  tags = {
    Name = "kc-vpc-nicolas-final"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "internet_gateway-final-nicolas"
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

resource "aws_route_table_association" "this" {
  for_each = var.availability_zone
  subnet_id = aws_subnet.this[each.key].id
  route_table_id = aws_route_table.this.id
}

resource "aws_subnet" "this" {
  for_each = var.availability_zone

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, each.value.cidr_block)
  map_public_ip_on_launch = true
  availability_zone       = each.value.availability_zone
  tags = {
    Name = each.value.name
  }
}*/

resource "aws_security_group" "this" {
  name        = var.name
  description = "practica-security-group-nicolas-final"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "this" {
  for_each = var.security_group_rule

  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr_blocks]
  security_group_id = aws_security_group.this.id
}

resource "aws_iam_role" "this" {
  name = var.aws_iam_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy_attachment" {
  policy_arn = var.policy_arn
  role       = aws_iam_role.this.name
}

resource "aws_ecs_task_definition" "this" {

  family                   = var.family
  network_mode             = var.network_mode
  requires_compatibilities = [var.requires_compatibilities]
  execution_role_arn       = aws_iam_role.this.arn
  cpu                      = var.container_definitions_cpu
  memory                   = var.container_definitions_memory
  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = var.cpu_architecture
  }

  container_definitions = jsonencode([
    {
      name      = var.container_definitions_name,
      image     = var.container_definitions_image
      essential = var.container_definitions_essential
      portMappings = [
        {
          containerPort = var.container_definitions_containerPort,
          hostPort      = var.container_definitions_hostPort
          protocol      = var.container_definitions_protocol
        }
      ]
    }
  ])
}

resource "aws_alb" "this" {
  name               = "LB-practica-final-nicolas"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = [var.subnets[0], var.subnets[1], var.subnets[2]]
}

resource "aws_alb_target_group" "this" {
  name        = "TG-practica-final-nicolas"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    protocol = "HTTP"
    path = "/"
  }
}

resource "aws_alb_listener" "this" {
  load_balancer_arn = aws_alb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}

resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_service" "this" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = var.ecs_service_launch_type
  desired_count = 2
  network_configuration {
    subnets         = [var.subnets[0], var.subnets[1], var.subnets[2]]
    security_groups = [aws_security_group.this.id]
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.this.arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [aws_ecs_task_definition.this, aws_alb.this]

}
