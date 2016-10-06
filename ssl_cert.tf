resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "self_signed_cert" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.private_key.private_key_pem}"

  subject {
    common_name         = "${var.env_name}.cf-app.com"
    country             = "US"
    province            = "California"
    locality            = "San Fransisco"
    organization        = "Pivotal"
    organizational_unit = "PCF Release Engineering"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_iam_server_certificate" "self_signed_cert" {
  name_prefix      = "${var.env_name}-"
  certificate_body = "${tls_self_signed_cert.self_signed_cert.cert_pem}"
  private_key      = "${tls_private_key.private_key.private_key_pem}"

  lifecycle {
    create_before_destroy = true
  }
}
