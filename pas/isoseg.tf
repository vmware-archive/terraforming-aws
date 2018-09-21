resource "tls_private_key" "isoseg_ssl_private_key" {
  algorithm = "RSA"
  rsa_bits  = "2048"

  count = "${length(var.isoseg_ssl_ca_cert) > 0 ? 1 : 0}"
}

resource "tls_cert_request" "isoseg_ssl_csr" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.isoseg_ssl_private_key.private_key_pem}"

  dns_names = [
    "*.iso.${var.env_name}.${var.dns_suffix}",
  ]

  count = "${length(var.isoseg_ssl_ca_cert) > 0 ? 1 : 0}"

  subject {
    common_name         = "${var.env_name}.${var.dns_suffix}"
    organization        = "Pivotal"
    organizational_unit = "Cloudfoundry"
    country             = "US"
    province            = "CA"
    locality            = "San Francisco"
  }
}

resource "tls_locally_signed_cert" "isoseg_ssl_cert" {
  cert_request_pem   = "${tls_cert_request.isoseg_ssl_csr.cert_request_pem}"
  ca_key_algorithm   = "RSA"
  ca_private_key_pem = "${var.isoseg_ssl_ca_private_key}"
  ca_cert_pem        = "${var.isoseg_ssl_ca_cert}"

  count = "${length(var.isoseg_ssl_ca_cert) > 0 ? 1 : 0}"

  validity_period_hours = 8760 # 1year

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_iam_server_certificate" "cert" {
  count = "${length(var.ssl_cert_arn) > 0 ? 0 : 1}"

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

resource "aws_security_group" "isoseg_elb_security_group" {
  count = "${var.create_isoseg_resources}"

  name        = "isoseg_elb_security_group"
  description = "Isoseg ELB Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 4443
    to_port     = 4443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-isoseg-elb-security-group"))}"
}

resource "aws_elb" "isoseg" {
  count = "${var.create_isoseg_resources}"

  name                      = "${var.env_name}-isoseg-elb"
  cross_zone_load_balancing = true

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 3
    interval            = 5
    target              = "HTTP:8080/health"
    timeout             = 3
  }

  idle_timeout = 3600

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = "${aws_iam_server_certificate.isoseg_cert.arn}"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "tcp"
    lb_port            = 4443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${aws_iam_server_certificate.isoseg_cert.arn}"
  }

  security_groups = ["${aws_security_group.isoseg_elb_security_group.id}"]
  subnets         = ["${var.public_subnet_ids}"]

  tags = "${var.tags}"
}

resource "aws_route53_record" "wildcard_iso_dns" {
  zone_id = "${var.zone_id}"
  name    = "*.iso.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300
  count   = "${min(var.create_isoseg_resources,1)}"

  records = ["${aws_elb.isoseg.dns_name}"]
}
