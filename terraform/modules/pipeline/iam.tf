resource "aws_iam_role" "codebuild_role" {
  name               = "codebuild-${var.ecs_cluster_name}-role"
  assume_role_policy = "${file("${path.module}/policies/codebuild_role.json")}"
}

data "template_file" "codebuild_policy" {
  template = "${file("${path.module}/policies/codebuild_policy.json")}"

  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.ecs_pipeline_bucket.arn}"
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "codebuild-${var.ecs_cluster_name}-policy"
  
  role = "${aws_iam_role.codebuild_role.id}"
  policy = "${data.template_file.codebuild_policy.rendered}"
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline-${var.ecs_cluster_name}-role"
  assume_role_policy = "${file("${path.module}/policies/codepipeline_role.json")}"
}

data "template_file" "codepipeline_policy" {
  template = "${file("${path.module}/policies/codepipeline_policy.json")}"

  vars {
    aws_s3_bucket_arn = "${aws_s3_bucket.ecs_pipeline_bucket.arn}"
  }
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline-${var.ecs_cluster_name}-policy"

  role = "${aws_iam_role.codepipeline_role.id}"
  policy = "${data.template_file.codepipeline_policy.rendered}"
}