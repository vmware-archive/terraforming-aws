resource "aws_route53_record" "name_servers" {
  count = "${var.top_level_zone_id == "" ? 0 : 1}"

  zone_id = "${var.top_level_zone_id}"
  name    = "${var.zone_name}"

  type = "NS"
  ttl  = 60

  records = ["${var.name_servers}"]
}
