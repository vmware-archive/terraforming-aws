resource "aws_iam_server_certificate" "cert" {
  name_prefix      = "${var.env_name}-"
  certificate_body = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, list("")), 0) : var.ssl_cert}"
  private_key      = "${length(var.ssl_ca_cert) > 0 ? element(concat(tls_private_key.ssl_private_key.*.private_key_pem, list("")), 0) : var.ssl_private_key}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_server_certificate" "isoseg_cert" {
  count = "${var.create_isoseg_resources}"

  name_prefix      = "${var.env_name}-isoseg"
  certificate_body = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.isoseg_ssl_cert.*.cert_pem, list("")), 0) : var.isoseg_ssl_cert}"
  private_key      = "${length(var.isoseg_ssl_ca_cert) > 0 ? element(concat(tls_private_key.isoseg_ssl_private_key.*.private_key_pem, list("")), 0) : var.isoseg_ssl_private_key}"

  lifecycle {
    create_before_destroy = true
  }
}
