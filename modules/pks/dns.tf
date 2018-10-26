locals {
  use_route53 = "${var.region == "us-gov-west-1" ? 0 : 1}"
}

resource "aws_route53_record" "pks_api_dns" {
  zone_id = "${var.zone_id}"
  name    = "api.pks.${var.env_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = "${aws_elb.pks_api_elb.dns_name}"
    zone_id                = "${aws_elb.pks_api_elb.zone_id}"
    evaluate_target_health = true
  }

  count = "${local.use_route53 ? 1 : 0}"
}
