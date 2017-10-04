output "ops_manager_bucket" {
  value = "${module.ops_manager.bucket}"
}

output "ert_buildpacks_bucket" {
  value = "${aws_s3_bucket.buildpacks_bucket.bucket}"
}

output "ert_droplets_bucket" {
  value = "${aws_s3_bucket.droplets_bucket.bucket}"
}

output "ert_packages_bucket" {
  value = "${aws_s3_bucket.packages_bucket.bucket}"
}

output "ert_resources_bucket" {
  value = "${aws_s3_bucket.resources_bucket.bucket}"
}

output "ops_manager_public_ip" {
  value = "${module.ops_manager.public_ip}"
}

output "ops_manager_dns" {
  value = "${module.ops_manager.dns}"
}

output "optional_ops_manager_dns" {
  value = "${module.ops_manager.optional_dns}"
}

output "env_dns_zone_name_servers" {
  value = "${aws_route53_zone.pcf_zone.name_servers}"
}

output "sys_domain" {
  value = "sys.${var.env_name}.${var.dns_suffix}"
}

output "apps_domain" {
  value = "apps.${var.env_name}.${var.dns_suffix}"
}

output "tcp_domain" {
  value = "tcp.${var.env_name}.${var.dns_suffix}"
}

output "iam_user_name" {
  value = "${aws_iam_user.iam_user.name}"
}

output "iam_user_access_key" {
  value = "${aws_iam_access_key.iam_user_access_key.id}"
}

output "iam_user_secret_access_key" {
  value = "${aws_iam_access_key.iam_user_access_key.secret}"
}

output "rds_address" {
  value = "${aws_db_instance.rds.address}"
}

output "rds_port" {
  value = "${aws_db_instance.rds.port}"
}

output "rds_username" {
  value = "${aws_db_instance.rds.username}"
}

output "rds_password" {
  value = "${aws_db_instance.rds.password}"
}

output "ops_manager_security_group_id" {
  value = "${module.ops_manager.security_group_id}"
}

output "vms_security_group_id" {
  value = "${aws_security_group.vms_security_group.id}"
}

output "public_subnet_ids" {
  value = ["${aws_subnet.public_subnets.*.id}"]
}

output "public_subnet_availability_zones" {
  value = ["${aws_subnet.public_subnets.*.availability_zone}"]
}

output "public_subnet_cidrs" {
  value = ["${aws_subnet.public_subnets.*.cidr_block}"]
}

output "management_subnet_ids" {
  value = ["${aws_subnet.management_subnets.*.id}"]
}

output "management_subnet_availability_zones" {
  value = ["${aws_subnet.management_subnets.*.availability_zone}"]
}

output "management_subnet_cidrs" {
  value = ["${aws_subnet.management_subnets.*.cidr_block}"]
}

output "ert_subnet_ids" {
  value = ["${aws_subnet.ert_subnets.*.id}"]
}

output "ert_subnet_availability_zones" {
  value = ["${aws_subnet.ert_subnets.*.availability_zone}"]
}

output "ert_subnet_cidrs" {
  value = ["${aws_subnet.ert_subnets.*.cidr_block}"]
}

output "services_subnet_ids" {
  value = ["${aws_subnet.services_subnets.*.id}"]
}

output "services_subnet_availability_zones" {
  value = ["${aws_subnet.services_subnets.*.availability_zone}"]
}

output "services_subnet_cidrs" {
  value = ["${aws_subnet.services_subnets.*.cidr_block}"]
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "ops_manager_ssh_private_key" {
  value = "${module.ops_manager.ssh_private_key}"
}

output "ops_manager_ssh_public_key_name" {
  value = "${module.ops_manager.ssh_public_key_name}"
}

output "region" {
  value = "${var.region}"
}

output "azs" {
  value = "${var.availability_zones}"
}

output "web_elb_name" {
  value = "${aws_elb.web_elb.name}"
}

output "ssh_elb_name" {
  value = "${aws_elb.ssh_elb.name}"
}

output "tcp_elb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "isoseg_elb_name" {
  value = "${aws_elb.isoseg.name}"
}

output "dns_zone_id" {
  value = "${aws_route53_zone.pcf_zone.id}"
}

output "ops_manager_private_ip" {
  value = "${module.ops_manager.ops_manager_private_ip}"
}