locals {
  use_route53 = "${var.region == "us-gov-west-1" ? 0 : 1}"
}

resource "aws_route53_record" "control_plane" {
  zone_id = "${var.zone_id}"
  name    = "plane.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_lb.control_plane.dns_name}"]
}