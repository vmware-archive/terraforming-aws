resource "aws_route53_record" "wildcard_sys_dns" {
  count   = "${var.use_route53 ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "*.sys.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.web_elb.dns_name}"]
}

resource "aws_route53_record" "wildcard_apps_dns" {
  count   = "${var.use_route53 ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "*.apps.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.web_elb.dns_name}"]
}

resource "aws_route53_record" "ssh" {
  count   = "${var.use_route53 ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "ssh.sys.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.ssh_elb.dns_name}"]
}

resource "aws_route53_record" "tcp" {
  count   = "${var.use_route53 ? 1 : 0}"
  zone_id = "${var.zone_id}"
  name    = "tcp.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.tcp_elb.dns_name}"]
}
