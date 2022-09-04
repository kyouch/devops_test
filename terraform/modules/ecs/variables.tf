variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "ecr_repository_name" {
  type        = string
  description = "ECR repository name"
}

variable "app_container_name" {
  type        = string
  description = "App container name"
}

variable "vpc_id" {
  type        = string
  description = "Created VPC ID"
}

variable "availability_zones" {
  type        = list
  description = "Availability Zones used"
}

variable "public_subnet_a" {
  type        = string
  description = "First Public Subnet"
}

variable "public_subnet_b" {
  type        = string
  description = "Second Public Subnet"
}

variable "alb_sg_id" {
  type        = string
  description = "App Load Balancer Security Group"
}

variable "app_sg_id" {
  type        = string
  description = "App Security Group"
}

variable "ecs_sg_id" {
  type        = string
  description = "ECS Security Group"
}

variable "security_groups_ids" {
  type        = list
  description = "Security groups IDs"
}

variable "desired_tasks" {
  type        = number
  description = "Desired number of containers running the app"
  default     = 1
}

variable "min_tasks" {
  type        = number
  description = "Minimum number of containers running the app"
  default     = 1
}

variable "max_tasks" {
  type        = number
  description = "Maximum number of containers running the app"
  default     = 2
}

variable "cpu_to_scale_up" {
  type        = number
  description = "CPU percentage usage to scale up the number of containers"
  default     = 80
}

variable "cpu_to_scale_down" {
  type        = number
  description = "CPU percentage usage to scale down the number of containers"
  default     = 30
}

variable "task_cpu" {
  type        = number
  description = "Desired CPU to run your tasks using Fargate"
  default     = 256
}

variable "task_memory" {
  type        = number
  description = "Desired Memory to run your tasks using Fargate"
  default     = 512
}

variable "alb_port" {
  type        = number
  description = "App load balancer endpoint port"
  default     = 80
}

variable "container_port" {
  type        = number
  description = "App container load balancer port"
  default     = 80
}