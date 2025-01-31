
resource "aws_appautoscaling_target" "app_scale_target" {
  service_namespace  = "ecs"
  scalable_dimension = "ecs:service:DesiredCount"
  max_capacity       = "${var.max_tasks}"
  min_capacity       = "${var.min_tasks}"

  resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.web_api.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${var.ecs_cluster_name}-CPU-Utilization-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_to_scale_up}"

  dimensions {
    ClusterName = "${aws_ecs_cluster.ecs-cluster.name}"
    ServiceName = "${aws_ecs_service.web_api.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.app_up.arn}"]
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = "${var.ecs_cluster_name}-app-scale-up"
  service_namespace  = "${aws_appautoscaling_target.app_scale_target.service_namespace}"
  resource_id        = "${aws_appautoscaling_target.app_scale_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.app_scale_target.scalable_dimension}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${var.ecs_cluster_name}-CPU-Utilization-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "${var.cpu_to_scale_down}"

  dimensions {
    ClusterName = "${aws_ecs_cluster.ecs-cluster.name}"
    ServiceName = "${aws_ecs_service.web_api.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.app_down.arn}"]
}


resource "aws_appautoscaling_policy" "app_down" {
  name               = "${var.ecs_cluster_name}-scale-down"
  service_namespace  = "${aws_appautoscaling_target.app_scale_target.service_namespace}"
  resource_id        = "${aws_appautoscaling_target.app_scale_target.resource_id}"
  scalable_dimension = "${aws_appautoscaling_target.app_scale_target.scalable_dimension}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}