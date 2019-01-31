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

# ============ Load Balancers ==================================================

output "web_target_groups" {
  value = [
    "${aws_lb_target_group.web_80.name}",
    "${aws_lb_target_group.web_443.name}",
  ]
}

output "tcp_target_groups" {
  value = "${aws_lb_target_group.tcp.*.name}"
}

output "ssh_target_groups" {
  value = ["${aws_lb_target_group.ssh.name}"]
}

output "isoseg_target_groups" {
  value = [
    "${element(concat(aws_lb_target_group.isoseg_80.*.name, list("")), 0)}",
    "${element(concat(aws_lb_target_group.isoseg_443.*.name, list("")), 0)}",
    "${element(concat(aws_lb_target_group.isoseg_4443.*.name, list("")), 0)}",
  ]
}

# ============== KMS ===========================================================

output "blobstore_kms_key_id" {
  value = "${aws_kms_key.blobstore_kms_key.key_id}"
}
