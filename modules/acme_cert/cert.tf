provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"

  version = "~> 1.2.1"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = "${tls_private_key.private_key.private_key_pem}"
  email_address   = "${var.registration_email}"
}

resource "acme_certificate" "certificate" {
  key_type                  = "P384"
  account_key_pem           = "${acme_registration.reg.account_key_pem}"
  common_name               = "${var.common_name}"
  subject_alternative_names = "${var.sans}"

  dns_challenge {
    provider = "route53"

    config {
      AWS_ACCESS_KEY_ID     = "${var.access_key}"
      AWS_SECRET_ACCESS_KEY = "${var.secret_key}"
      AWS_HOSTED_ZONE_ID    = "${var.aws_hosted_zone}"
    }
  }
}
