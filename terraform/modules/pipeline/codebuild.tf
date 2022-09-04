data "template_file" "buildspec" {
  template = "${file("${path.module}/buildspec.yml")}"

  vars {
    aws_region         = "${var.aws_region}"
    app_container_name = "${var.app_container_name}"
    repository_url     = "${var.repository_url}"
  }
}

resource "aws_codebuild_project" "app_build" {
  name          = "${var.ecs_cluster_name}-codebuild"
  description   = "go-healthcheck-app container build"
  build_timeout = 10

  service_role = "${aws_iam_role.codebuild_role.arn}"
  
  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/docker:17.09.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "${data.template_file.buildspec.rendered}"
  }
}
