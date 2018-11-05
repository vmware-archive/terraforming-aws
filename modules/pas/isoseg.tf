locals {
  create_isoseg_resources = "${length(var.isoseg_ssl_cert_arn) > 0 ? 1 : 0}"
}

resource "aws_security_group" "isoseg_elb_security_group" {
  count = "${local.create_isoseg_resources}"

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
  count = "${local.create_isoseg_resources}"

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
    ssl_certificate_id = "${var.isoseg_ssl_cert_arn}"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "tcp"
    lb_port            = 4443
    lb_protocol        = "ssl"
    ssl_certificate_id = "${var.isoseg_ssl_cert_arn}"
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
  count   = "${local.create_isoseg_resources}"

  records = ["${aws_elb.isoseg.dns_name}"]
}
