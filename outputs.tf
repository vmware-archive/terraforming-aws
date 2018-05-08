output "iaas" {
  value = "aws"
}

output "ops_manager_bucket" {
  value = "${module.ops_manager.bucket}"
}

output "pas_buildpacks_bucket" {
  value = "${aws_s3_bucket.buildpacks_bucket.bucket}"
}

output "pas_droplets_bucket" {
  value = "${aws_s3_bucket.droplets_bucket.bucket}"
}

output "pas_packages_bucket" {
  value = "${aws_s3_bucket.packages_bucket.bucket}"
}

output "pas_resources_bucket" {
  value = "${aws_s3_bucket.resources_bucket.bucket}"
}

output "blobstore_kms_key_id" {
  value = "${aws_kms_key.blobstore_kms_key.key_id}"
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
  value = ["${split(",", local.name_servers)}"]
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

output "ops_manager_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.ops_manager.name}"
}

output "ops_manager_iam_user_name" {
  value = "${aws_iam_user.ops_manager.name}"
}

output "ops_manager_iam_user_access_key" {
  value = "${aws_iam_access_key.ops_manager.id}"
}

output "ops_manager_iam_user_secret_key" {
  value = "${aws_iam_access_key.ops_manager.secret}"
}

output "pas_bucket_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.pas_bucket_access.name}"
}

output "rds_address" {
  value = "${element(concat(aws_db_instance.rds.*.address, list("")), 0)}"
}

output "rds_port" {
  value = "${element(concat(aws_db_instance.rds.*.port, list("")), 0)}"
}

output "rds_username" {
  value = "${element(concat(aws_db_instance.rds.*.username, list("")), 0)}"
}

output "rds_password" {
  sensitive = true
  value     = "${element(concat(aws_db_instance.rds.*.password, list("")), 0)}"
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

output "public_subnets" {
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

output "management_subnets" {
  value = ["${aws_subnet.management_subnets.*.id}"]
}

output "management_subnet_availability_zones" {
  value = ["${aws_subnet.management_subnets.*.availability_zone}"]
}

output "management_subnet_cidrs" {
  value = ["${aws_subnet.management_subnets.*.cidr_block}"]
}

output "pas_subnet_ids" {
  value = ["${aws_subnet.pas_subnets.*.id}"]
}

output "pas_subnets" {
  value = ["${aws_subnet.pas_subnets.*.id}"]
}

output "pas_subnet_availability_zones" {
  value = ["${aws_subnet.pas_subnets.*.availability_zone}"]
}

output "pas_subnet_cidrs" {
  value = ["${aws_subnet.pas_subnets.*.cidr_block}"]
}

output "services_subnet_ids" {
  value = ["${aws_subnet.services_subnets.*.id}"]
}

output "services_subnets" {
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

output "network_name" {
  value = "${aws_vpc.vpc.id}"
}

output "ops_manager_ssh_private_key" {
  sensitive = true
  value     = "${module.ops_manager.ssh_private_key}"
}

output "ops_manager_ssh_public_key_name" {
  value = "${module.ops_manager.ssh_public_key_name}"
}

output "ops_manager_ssh_public_key" {
  value = "${module.ops_manager.ssh_public_key}"
}

output "region" {
  value = "${var.region}"
}

output "azs" {
  value = "${var.availability_zones}"
}

output "web_lb_name" {
  value = "${aws_elb.web_elb.name}"
}

output "web_elb_name" {
  value = "${aws_elb.web_elb.name}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, list("")), 0) : var.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_private_key.ssl_private_key.*.private_key_pem, list("")), 0) : var.ssl_private_key}"
}

output "ssh_lb_name" {
  value = "${aws_elb.ssh_elb.name}"
}

output "ssh_elb_name" {
  value = "${aws_elb.ssh_elb.name}"
}

output "tcp_lb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "tcp_elb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "isoseg_elb_name" {
  value = "${element(concat(aws_elb.isoseg.*.name, list("")), 0)}"
}

output "isoseg_ssl_cert" {
  sensitive = true
  value     = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.isoseg_ssl_cert.*.cert_pem, list("")), 0) : var.isoseg_ssl_cert}"
}

output "isoseg_ssl_private_key" {
  sensitive = true
  value     = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_private_key.isoseg_ssl_private_key.*.private_key_pem, list("")), 0) : var.isoseg_ssl_private_key}"
}

output "dns_zone_id" {
  value = "${aws_route53_zone.pcf_zone.id}"
}

output "ops_manager_ip" {
  value = "${module.ops_manager.ops_manager_private_ip}"
}

output "ops_manager_private_ip" {
  value = "${module.ops_manager.ops_manager_private_ip}"
}
