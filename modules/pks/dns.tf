resource "aws_route53_record" "wildcard_sys_dns" {
  zone_id = "${var.zone_id}"
  name    = "*.pks.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.pks_api_elb.dns_name}"]

  count = "${var.use_route53 ? 1 : 0}"
}
