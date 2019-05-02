output "domain" {
  value = "${aws_route53_record.control_plane.*.name}"
}

output "subnet_ids" {
  value = ["${aws_subnet.control_plane.*.id}"]
}

output "subnet_gateways" {
  value = ["${data.template_file.subnet_gateways.*.rendered}"]
}

output "subnet_cidrs" {
  value = ["${aws_subnet.control_plane.*.cidr_block}"]
}

output "subnet_availability_zones" {
  value = ["${aws_subnet.control_plane.*.availability_zone}"]
}

output "credhub_lb_target_group" {
  value = "${aws_lb_target_group.credhub.name}"
}

output "uaa_lb_target_group" {
  value = "${aws_lb_target_group.uaa.name}"
}

output "atc_lb_target_group" {
  value = "${aws_lb_target_group.atc.name}"
}

output "credhub_security_group" {
  value = "${aws_security_group.credhub.name}"
}

output "uaa_security_group" {
  value = "${aws_security_group.uaa.name}"
}

output "atc_security_group" {
  value = "${aws_security_group.control_plane.name}"
}
