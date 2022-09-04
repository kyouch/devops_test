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

variable "account_id" {
  type        = string
  description = "AWS account ID"
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

variable "repository_url" {
  type        = string
  description = "URL of the craeted ECR repository"
}

variable "vpc_id" {
  type        = string
  description = "Created VPC ID"
}

variable "subnet_ids" {
  type        = list
  description = "Created VPC subnet IDs"
}