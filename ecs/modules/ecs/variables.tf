variable "vpc_id"{
  type = string
  default = null
  description = "VPC id"
}

variable "subnets"{
  type = list(string)
  default = []
  description = "Subnets information"
}


variable "cidr_block" {
  type        = string
  default     = null
  description = "VPC cidr block"
}

variable "dns_hostnames" {
  type        = bool
  default     = false
  description = "DNS Hostnames"
}

variable "availability_zone" {
  type        = map(any)
  default     = {}
  description = "Subnets Availability Zones"
}

variable "name" {
  type        = string
  default     = null
  description = "Security Group Name"
}

variable "security_group_rule" {
  type        = map(any)
  default     = {}
  description = "AWS Security Group rule"
}

variable "family" {
  type        = string
  default     = null
  description = "ECS task definition family"
}

variable "network_mode" {
  type        = string
  default     = null
  description = "ECS task definition network mode"
}

variable "requires_compatibilities" {
  type        = string
  default     = null
  description = "ECS task definition compatibilities"
}

variable "operating_system_family" {
  type        = string
  default     = null
  description = "Operating system"
}

variable "cpu_architecture" {
  type        = string
  default     = null
  description = "cpu Architecture"
}

variable "container_definitions_name" {
  type        = string
  default     = null
  description = "Container Image Name"
}

variable "container_definitions_image" {
  type        = string
  default     = null
  description = "Container Image Version"
}

variable "container_definitions_essential" {
  type        = bool
  default     = false
  description = "Container Image Essential"
}

variable "container_definitions_memory" {
  type        = number
  default     = 0
  description = "Container Image memory"
}

variable "container_definitions_cpu" {
  type        = number
  default     = 0
  description = "Container Image cpu"
}

variable "container_definitions_containerPort" {
  type        = number
  default     = 0
  description = "Container Port"
}

variable "container_definitions_hostPort" {
  type        = number
  default     = 0
  description = "Host Port"
}

variable "container_definitions_protocol" {
  type        = string
  default     = null
  description = "Container Protocol"
}

variable "aws_iam_role_name" {
  type        = string
  default     = null
  description = "IAM role name"
}

variable "aws_iam_role_version" {
  type        = string
  default     = null
  description = "IAM role version"
}

variable "aws_iam_role_action" {
  type        = string
  default     = null
  description = "IAM role action"
}

variable "aws_iam_role_effect" {
  type        = string
  default     = null
  description = "IAM role effect"
}

variable "aws_iam_role_service" {
  type        = string
  default     = null
  description = "IAM role Service"
}

variable "policy_arn" {
  type        = string
  default     = null
  description = "Policy ARN"
}

variable "ecs_cluster_name" {
  type        = string
  default     = null
  description = "Cluster Name"
}

variable "ecs_service_name" {
  type        = string
  default     = null
  description = "Service Name"
}

variable "ecs_service_launch_type" {
  type        = string
  default     = null
  description = "Service Launch Type"
}
