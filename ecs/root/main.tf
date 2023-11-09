module "kc-ecs-final" {

  source = "../modules/ecs"

  vpc_id = data.aws_vpc.default_vpc.id
  subnets = data.aws_subnets.this.ids
  cidr_block    = "10.0.0.0/16"
  dns_hostnames = true

  availability_zone = {
    subnet1 = {
      "cidr_block" : 1
      "availability_zone" : "eu-west-1a"
      "name" : "subnet1"
    },
    subnet2 = {
      "cidr_block" : 2
      "availability_zone" : "eu-west-1b"
      "name" : "subnet2"
    }
  }

  name = "practica-security-group-nicolas-final"

  security_group_rule = {
    ingress = {
      "type" : "ingress"
      "from_port" : 80
      "to_port" : 80
      "protocol" : "tcp"
      "cidr_blocks" : "0.0.0.0/0"
    },
    egress = {
      "type" : "egress"
      "from_port" : 0
      "to_port" : 0
      "protocol" : "-1"
      "cidr_blocks" : "0.0.0.0/0"
    }
  }

  family                              = "kc-task-definition-final-nicolas"
  network_mode                        = "awsvpc"
  requires_compatibilities            = "FARGATE"
  container_definitions_name          = "nginx"
  container_definitions_image         = "nginx:latest"
  operating_system_family             = "LINUX"
  cpu_architecture                    = "X86_64"
  container_definitions_essential     = true
  container_definitions_memory        = 3072
  container_definitions_cpu           = 1024
  container_definitions_containerPort = 80
  container_definitions_hostPort      = 80
  container_definitions_protocol      = "tcp"
  aws_iam_role_name                   = "ecs-execution-role-nicolas-final"
  aws_iam_role_version                = "2012-10-17"
  aws_iam_role_action                 = "sts:AssumeRole"
  aws_iam_role_effect                 = "Allow"
  aws_iam_role_service                = "ecs-tasks.amazonaws.com"
  policy_arn                          = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ecs_cluster_name                    = "nginx-cluster-final-nicolas"
  ecs_service_name                    = "nginx-service-final-nicolas"
  ecs_service_launch_type             = "FARGATE"
}
