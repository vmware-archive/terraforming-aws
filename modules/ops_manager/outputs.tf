output "bucket" {
  value = "${element(concat(aws_s3_bucket.ops_manager_bucket.*.bucket, list("")), 0)}"
}

output "public_ip" {
  value = "${var.vm_count ? element(concat(aws_eip.ops_manager_attached.*.public_ip, list("")), 0) : element(concat(aws_eip.ops_manager_unattached.*.public_ip, list("")), 0)}"
}

output "dns" {
  value = "${var.vm_count ? element(concat(aws_route53_record.ops_manager_attached_eip.*.name, list("")), 0) : element(concat(aws_route53_record.ops_manager_unattached_eip.*.name, list("")), 0)}"
}

output "optional_dns" {
  value = "${element(concat(aws_route53_record.optional_ops_manager.*.name, list("")), 0)}"
}

output "optional_public_ip" {
  value = "${element(concat(aws_eip.optional_ops_manager.*.public_ip, list("")), 0)}"
}

output "security_group_id" {
  value = "${element(concat(aws_security_group.ops_manager_security_group.*.id, list("")), 0)}"
}

output "ssh_private_key" {
  value = "${element(concat(tls_private_key.ops_manager.*.private_key_pem, list("")), 0)}"
}

output "ssh_public_key_name" {
  value = "${element(concat(aws_key_pair.ops_manager.*.key_name, list("")), 0)}"
}

output "ssh_public_key" {
  value = "${element(concat(aws_key_pair.ops_manager.*.public_key, list("")), 0)}"
}

output "ops_manager_private_ip" {
  value = "${element(concat(aws_instance.ops_manager.*.private_ip, list("")), 0)}"
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
  value     = "${aws_iam_access_key.ops_manager.secret}"
  sensitive = true
}

output "ops_manager_iam_role_name" {
  value = "${aws_iam_role.ops_manager.name}"
}
