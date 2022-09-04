resource "aws_ecr_repository" "ecs_app" {
  name = "${var.ecr_repository_name}"
}