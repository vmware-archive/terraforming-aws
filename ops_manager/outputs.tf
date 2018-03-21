output "bucket" {
  value = "${element(concat(aws_s3_bucket.ops_manager_bucket.*.bucket, list("")), 0)}"
}

output "public_ip" {
  value = "${element(concat(aws_eip.ops_manager.*.public_ip, list("")), 0)}"
}

output "dns" {
  value = "${element(concat(aws_route53_record.ops_manager.*.name, list("")), 0)}"
}

output "optional_dns" {
  value = "${element(concat(aws_route53_record.optional_ops_manager.*.name, list("")), 0)}"
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
