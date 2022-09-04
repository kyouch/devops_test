resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.ecs_cluster_name}-ecs-task-role"
  assume_role_policy = "${file("${path.module}/policies/ecs-task-execution-role.json")}"
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name = "${var.ecs_cluster_name}-role-policy"

  role = "${aws_iam_role.ecs_execution_role.id}"
  policy = "${file("${path.module}/policies/ecs-execution-role-policy.json")}"
}
