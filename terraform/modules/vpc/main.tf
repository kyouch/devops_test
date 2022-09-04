resource "aws_vpc" "ecs_vpc" {
  cidr_block           = "10.0.0.0/24" 
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.ecs_cluster_name}-vpc"
  }
}

resource "aws_internet_gateway" "ecs_gw" {
  vpc_id = "${aws_vpc.ecs_vpc.id}"

  tags = {
    Name = "${var.ecs_cluster_name}-igw"
  }
}

resource "aws_route" "external_access" {
  destination_cidr_block = "0.0.0.0/0"

  route_table_id = "${aws_vpc.ecs_vpc.main_route_table_id}"
  gateway_id = "${aws_internet_gateway.ecs_gw.id}"

  tags = {
    Name = "${var.ecs_cluster_name}-r"
  }
}