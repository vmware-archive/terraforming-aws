resource "aws_route53_record" "ops_manager" {
  name    = "pcf.${var.env_name}.${var.dns_suffix}"
  zone_id = "${var.zone_id}"
  type    = "A"
  ttl     = 300
  count   = "${var.count}"

  records = ["${aws_eip.ops_manager.public_ip}"]
}

resource "aws_route53_record" "optional_ops_manager" {
  name    = "pcf-optional.${var.env_name}.${var.dns_suffix}"
  zone_id = "${var.zone_id}"
  type    = "A"
  ttl     = 300
  count   = "${var.optional_count}"

  records = ["${aws_eip.optional_ops_manager.public_ip}"]
}
