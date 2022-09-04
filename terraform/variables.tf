variable "git_repository_owner" {
  type        = string
  description = "GitHub repository owner"
}

variable "git_repository_name" {
  type        = string
  description = "GitHub repository name"
}

variable "git_repository_branch" {
  type        = string
  description = "GitHub repository branch"
  default     = "main"
}

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

variable "app_service_name" {
  type        = string
  description = "App service name"
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