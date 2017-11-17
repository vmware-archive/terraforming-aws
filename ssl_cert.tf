resource "aws_iam_server_certificate" "cert" {
  name_prefix      = "${var.env_name}-"
  certificate_body = "${var.ssl_cert}"
  private_key      = "${var.ssl_private_key}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_server_certificate" "isoseg_cert" {
  count = "${var.create_isoseg_resources}"

  name_prefix      = "${var.env_name}-isoseg"
  certificate_body = "${var.isoseg_ssl_cert}"
  private_key      = "${var.isoseg_ssl_private_key}"

  lifecycle {
    create_before_destroy = true
  }
}
