variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
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