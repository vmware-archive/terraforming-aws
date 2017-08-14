output "bucket" {
  value = "${aws_s3_bucket.ops_manager_bucket.bucket}"
}

output "public_ip" {
  value = "${aws_eip.ops_manager.public_ip}"
}

output "dns" {
  value = "${aws_route53_record.ops_manager.name}"
}

output "optional_dns" {
  value = "${aws_route53_record.optional_ops_manager.name}"
}

output "security_group_id" {
  value = "${aws_security_group.ops_manager_security_group.id}"
}

output "ssh_private_key" {
  value = "${tls_private_key.ops_manager.private_key_pem}"
}

output "ssh_public_key_name" {
  value = "${aws_key_pair.ops_manager.key_name}"
}

output "ops_manager_private_ip" {
  value = "${aws_instance.ops_manager.private_ip}"
}