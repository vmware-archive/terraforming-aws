output "pks_api_target_groups" {
  value = [
    "${aws_lb_target_group.pks_api_9021.name}",
    "${aws_lb_target_group.pks_api_8443.name}",
  ]
}

output "pks_subnet_ids" {
  value = ["${aws_subnet.pks_subnets.*.id}"]
}

output "pks_subnet_availability_zones" {
  value = ["${aws_subnet.pks_subnets.*.availability_zone}"]
}

output "pks_subnet_gateways" {
  value = ["${data.template_file.pks_subnet_gateways.*.rendered}"]
}

output "pks_subnet_cidrs" {
  value = ["${aws_subnet.pks_subnets.*.cidr_block}"]
}

output "services_subnet_ids" {
  value = ["${aws_subnet.services_subnets.*.id}"]
}

output "services_subnet_availability_zones" {
  value = ["${aws_subnet.services_subnets.*.availability_zone}"]
}

output "services_subnet_gateways" {
  value = ["${data.template_file.services_subnet_gateways.*.rendered}"]
}

output "services_subnet_cidrs" {
  value = ["${aws_subnet.services_subnets.*.cidr_block}"]
}

output "pks_master_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.pks_master.name}"
}

output "pks_master_iam_role_arn" {
  value = "${aws_iam_role.pks_master.arn}"
}

output "pks_worker_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.pks_worker.name}"
}

output "pks_worker_iam_role_arn" {
  value = "${aws_iam_role.pks_worker.arn}"
}

output "domain" {
  value = "api.pks.${var.env_name}.${var.dns_suffix}"
}

output "pks_master_security_group_id" {
  value = "${aws_security_group.pks_master_security_group.id}"
}
