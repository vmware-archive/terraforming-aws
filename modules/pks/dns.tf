locals {
  use_route53 = "${var.region == "us-gov-west-1" ? 0 : 1}"
}

resource "aws_route53_record" "wildcard_sys_dns" {
  zone_id = "${var.zone_id}"
  name    = "*.pks.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_lb.pks_api.dns_name}"]

  count = "${local.use_route53 ? 1 : 0}"
}
