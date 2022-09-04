resource "aws_subnet" "a" {
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  vpc_id = "${aws_vpc.ecs_vpc.id}"

  tags = {
    Name = "${var.ecs_cluster_name}-vpc-sn-a"
  }
}

resource "aws_subnet" "b" {
  cidr_block              = "10.0.0.128/24"
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  vpc_id = "${aws_vpc.ecs_vpc.id}"

  tags = {
    Name = "${var.ecs_cluster_name}-vpc-sn-b"
  }
}

resource "aws_route_table_association" "a_association" {
  subnet_id = "${aws_subnet.a.id}"
  route_table_id = "${aws_vpc.ecs_vpc.main_route_table_id}"
}

resource "aws_route_table_association" "b_association" {
  subnet_id = "${aws_subnet.b.id}"
  route_table_id = "${aws_vpc.ecs_vpc.main_route_table_id}"
}
