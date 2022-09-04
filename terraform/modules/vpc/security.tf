resource "aws_security_group" "alb_sg" {
  name        = "${var.ecs_cluster_name}-alb-sg"
  description = "App load balancer endpoint security group"

  vpc_id = "${aws_vpc.ecs_vpc.id}"

  ingress {
    from_port   = "${var.alb_port}"
    to_port     = "${var.container_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecs_cluster_name}-alb-sg"
  }

  depends_on = ["aws_vpc.ecs_vpc"]
}

resource "aws_security_group" "app_sg" {
  name        = "${var.ecs_cluster_name}-app-sg"
  description = "App service security group"

  vpc_id      = "${aws_vpc.ecs_vpc.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  tags = {
    Name = "${var.ecs_cluster_name}-app-sg"
  }

  depends_on  = ["aws_vpc.ecs_vpc"]
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.ecs_cluster_name}-ecs-sg"
  description = "Container security group"

  vpc_id = "${aws_vpc.ecs_vpc.id}"

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.ecs_cluster_name}-ecs-sg"
  }

  depends_on = ["aws_vpc.ecs_vpc"]
}