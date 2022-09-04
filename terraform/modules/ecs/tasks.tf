data "template_file" "api_task" {
  template = "${file("${path.module}/task-definitions/api-task.json")}"

  vars {
    aws_region         = "${var.aws_region}"
    app_container_name = "${var.app_container_name}"
    container_port     = "${var.container_port}"
    task_cpu           = "${var.task_cpu}"
    task_memory        = "${var.task_memory}"
    image              = "${aws_ecr_repository.ecs_app.repository_url}"
    log_group          = "${aws_cloudwatch_log_group.ecs-logs.name}"
  }
}

resource "aws_ecs_task_definition" "web_api" {
  family                   = "${var.ecs_cluster_name}-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "${var.task_cpu}"
  memory                   = "${var.task_memory}"
  container_definitions    = "${data.template_file.api_task.rendered}"

  execution_role_arn = "${aws_iam_role.ecs_execution_role.arn}"
  task_role_arn      = "${aws_iam_role.ecs_execution_role.arn}"
}
