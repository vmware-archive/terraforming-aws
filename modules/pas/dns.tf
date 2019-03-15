resource "aws_route53_record" "wildcard_sys_dns" {
  count   = "${var.use_route53}"
  zone_id = "${var.zone_id}"
  name    = "*.sys.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_lb.web.dns_name}"
    zone_id                = "${aws_lb.web.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard_apps_dns" {
  count   = "${var.use_route53}"
  zone_id = "${var.zone_id}"
  name    = "*.apps.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_lb.web.dns_name}"
    zone_id                = "${aws_lb.web.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh" {
  count   = "${var.use_route53}"
  zone_id = "${var.zone_id}"
  name    = "ssh.sys.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_lb.ssh.dns_name}"
    zone_id                = "${aws_lb.ssh.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tcp" {
  count   = "${var.use_route53}"
  zone_id = "${var.zone_id}"
  name    = "tcp.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_lb.tcp.dns_name}"
    zone_id                = "${aws_lb.tcp.zone_id}"
    evaluate_target_health = true
  }
}
