output "ops_manager_bucket" {
  value = "${aws_s3_bucket.ops_manager_bucket.arn}"
}

output "ert_buildpacks_bucket" {
  value = "${aws_s3_bucket.buildpacks_bucket.arn}"
}

output "ert_droplets_bucket" {
  value = "${aws_s3_bucket.droplets_bucket.arn}"
}

output "ert_packages_bucket" {
  value = "${aws_s3_bucket.packages_bucket.arn}"
}

output "ert_resources_bucket" {
  value = "${aws_s3_bucket.resources_bucket.arn}"
}

output "ops_manager_dns" {
  value = "${aws_route53_record.ops_manager.name}"
}

output "env_dns_zone_name_servers" {
  value = "${aws_route53_zone.pcf_zone.name_servers}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "ssh_elb_dns_name" {
  value = "${aws_elb.ssh_elb.dns_name}"
}

output "tcp_elb_dns_name" {
  value = "${aws_elb.tcp_elb.dns_name}"
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
  value = "${var.rds_db_password}"
}

output "rds_db_name" {
  value = "${aws_db_instance.rds.name}"
}

output "ops_manager_security_group_id" {
  value = "${aws_security_group.ops_manager_security_group.id}"
}

output "vms_security_group_id" {
  value = "${aws_security_group.vms_security_group.id}"
}

output "public_subnet1_id" {
  value = "${aws_subnet.public_subnets.0.id}"
}

output "public_subnet2_id" {
  value = "${aws_subnet.public_subnets.1.id}"
}

output "public_subnet1_availability_zone" {
  value = "${aws_subnet.public_subnets.0.availability_zone}"
}

output "public_subnet2_availability_zone" {
  value = "${aws_subnet.public_subnets.1.availability_zone}"
}

output "private_subnet1_id" {
  value = "${aws_subnet.private_subnets.0.id}"
}

output "private_subnet2_id" {
  value = "${aws_subnet.private_subnets.1.id}"
}

output "private_subnet1_availability_zone" {
  value = "${aws_subnet.private_subnets.0.availability_zone}"
}

output "private_subnet2_availability_zone" {
  value = "${aws_subnet.private_subnets.1.availability_zone}"
}

output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "ops_manager_private_key" {
  value = "${tls_private_key.ops_manager.private_key_pem}"
}

output "ops_manager_public_key_name" {
  value = "${aws_key_pair.ops_manager.key_name}"
}
