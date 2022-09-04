resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.ecs_cluster_name}"
}

resource "aws_cloudwatch_log_group" "ecs-logs" {
  name = "${var.ecs_cluster_name}-logs"

  tags {
    Application = "${var.app_container_name}"
  }
}
