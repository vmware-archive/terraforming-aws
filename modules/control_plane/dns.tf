resource "aws_route53_record" "control_plane" {
  count   = "${var.use_route53}"

  zone_id = "${var.zone_id}"
  name    = "plane.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_lb.control_plane.dns_name}"]
}