resource "aws_route53_record" "name_servers" {
  zone_id = "${var.top_level_zone_id}"
  name    = "${var.env_name}.${var.dns_suffix}"

  type = "NS"
  ttl  = 60

  records = ["${module.infra.name_servers}"]
}

variable "top_level_zone_id" {
  description = "top level aws zone id that NS records will be added to"
}
