resource "aws_s3_bucket" "ecs_pipeline_bucket" {
  bucket = "${var.ecs_cluster_name}-pipeline"
}

resource "aws_s3_bucket_acl" "ecs_pipeline_bucket" {
  bucket = aws_s3_bucket.ecs_pipeline_bucket.id
  acl    = "private"
}