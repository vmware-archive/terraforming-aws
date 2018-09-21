# ========= Subnets ============================================================

output "pas_subnet_ids" {
  value = ["${aws_subnet.pas_subnets.*.id}"]
}

output "pas_subnet_availability_zones" {
  value = ["${aws_subnet.pas_subnets.*.availability_zone}"]
}

output "pas_subnet_cidrs" {
  value = ["${aws_subnet.pas_subnets.*.cidr_block}"]
}

output "pas_subnet_gateways" {
  value = ["${data.template_file.pas_subnet_gateways.*.rendered}"]
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

output "services_subnet_gateways" {
  value = ["${data.template_file.services_subnet_gateways.*.rendered}"]
}

output "pas_bucket_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.pas_bucket_access.name}"
}

output "iam_pas_bucket_role_arn" {
  value = "${aws_iam_role.pas_bucket_access.arn}"
}

# ========= Buckets ============================================================

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

output "pas_buildpacks_backup_bucket" {
  value = "${element(concat(aws_s3_bucket.buildpacks_backup_bucket.*.bucket, list("")), 0)}"
}

output "pas_droplets_backup_bucket" {
  value = "${element(concat(aws_s3_bucket.droplets_backup_bucket.*.bucket, list("")), 0)}"
}

output "pas_packages_backup_bucket" {
  value = "${element(concat(aws_s3_bucket.packages_backup_bucket.*.bucket, list("")), 0)}"
}

output "pas_resources_backup_bucket" {
  value = "${element(concat(aws_s3_bucket.resources_backup_bucket.*.bucket, list("")), 0)}"
}

# ========= Certificates =======================================================

output "ssl_cert_arn" {
  value = "${var.ssl_cert_arn}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, list("")), 0) : var.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_private_key.ssl_private_key.*.private_key_pem, list("")), 0) : var.ssl_private_key}"
}

# ======== Isolation Segment ===================================================

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


# ============ Load Balancers ==================================================

output "web_lb_name" {
  value = "${aws_elb.web_elb.name}"
}

output "tcp_lb_name" {
  value = "${aws_elb.tcp_elb.name}"
}

output "ssh_lb_name" {
  value = "${aws_elb.ssh_elb.name}"
}

# ============== KMS ===========================================================

output "blobstore_kms_key_id" {
  value = "${aws_kms_key.blobstore_kms_key.key_id}"
}
