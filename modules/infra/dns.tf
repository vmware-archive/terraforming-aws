locals {
  data_zone_id     = "${element(concat(data.aws_route53_zone.pcf_zone.*.zone_id, list("")), 0)}"
  resource_zone_id = "${element(concat(aws_route53_zone.pcf_zone.*.zone_id, list("")), 0)}"
  zone_id          = "${var.hosted_zone == "" ? local.resource_zone_id : local.data_zone_id}"

  hosted_zone_count = "${var.hosted_zone == "" ? 0 : 1}"

  data_dns_name_servers     = "${join(",", flatten(data.aws_route53_zone.pcf_zone.*.name_servers))}"
  resource_dns_name_servers = "${join(",", flatten(aws_route53_zone.pcf_zone.*.name_servers))}"
  name_servers              = "${split(",", local.hosted_zone_count > 0 ? local.data_dns_name_servers: local.resource_dns_name_servers)}"
}

data "aws_route53_zone" "pcf_zone" {
  count = "${var.use_route53 ? local.hosted_zone_count : 0}"

  name = "${var.hosted_zone}"
}

resource "aws_route53_zone" "pcf_zone" {
  count = "${var.use_route53 ? (1 - local.hosted_zone_count) : 0}"

  name = "${var.env_name}.${var.dns_suffix}"

  tags = "${merge(var.tags, map("Name", "${var.env_name}-hosted-zone"))}"
}
