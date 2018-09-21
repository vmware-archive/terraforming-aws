output "ssl_cert_arn" {
  value = "${length(var.ssl_cert_arn) > 0 ? var.ssl_cert_arn : element(concat(aws_iam_server_certificate.cert.*.arn, list("")), 0)}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, list("")), 0) : var.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_private_key.ssl_private_key.*.private_key_pem, list("")), 0) : var.ssl_private_key}"
}
