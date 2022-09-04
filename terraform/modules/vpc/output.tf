output "vpc_id" {
  value = "${aws_vpc.ecs_vpc.id}"
}

output "vpc_sn_a" {
  value = "${aws_subnet.a.*.id}"
}

output "vpc_sn_b" {
  value = "${aws_subnet.b.*.id}"
}

output "alb_sg_id" {
  value = "${aws_security_group.alb_sg.id}"
}

output "app_sg_id" {
  value = "${aws_security_group.app_sg.id}"
}

output "ecs_sg_id" {
  value = "${aws_security_group.ecs_sg.id}"
}