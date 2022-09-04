resource "aws_ecs_service" "web_api" {
  name            = "${var.ecs_cluster_name}"
  launch_type     = "FARGATE"
  desired_count   = "${var.desired_tasks}"

  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.web_api.arn}"

  network_configuration {
    subnets          = ["${var.availability_zones}"]
    security_groups  = ["${var.security_groups_ids}"]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn   = "${aws_alb_target_group.api_target_group.arn}"
    app_container_name = "${var.app_container_name}"
    container_port     = "${var.container_port}"
  }
  
  lifecycle {
    ignore_changes = ["desired_count", "task_definition"]
  }  

  depends_on = ["aws_alb_target_group.api_target_group"]
}
