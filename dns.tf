locals {
  data_zone_id     = "${element(concat(data.aws_route53_zone.pcf_zone.*.zone_id, list("")), 0)}"
  resource_zone_id = "${element(concat(aws_route53_zone.pcf_zone.*.zone_id, list("")), 0)}"
  zone_id          = "${var.hosted_zone == "" ? local.resource_zone_id : local.data_zone_id}"

  data_dns_name_servers     = "${join(",", flatten(concat(data.aws_route53_zone.pcf_zone.*.name_servers, list(list("")))))}"
  resource_dns_name_servers = "${join(",", flatten(concat(aws_route53_zone.pcf_zone.*.name_servers, list(list("")))))}"
  name_servers              = "${var.hosted_zone == "" ? local.resource_dns_name_servers : local.data_dns_name_servers}"
}

data "aws_route53_zone" "pcf_zone" {
  count = "${var.hosted_zone == "" ? 0 : 1}"

  name = "${var.hosted_zone}"
}

resource "aws_route53_zone" "pcf_zone" {
  count = "${var.hosted_zone == "" ? 1 : 0}"

  name = "${var.env_name}.${var.dns_suffix}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-hosted-zone")
  )}"
}

resource "aws_route53_record" "name_servers" {
  count = "${var.hosted_zone == "" ? 0 : 1}"

  zone_id = "${local.zone_id}"
  name    = "${var.env_name}.${var.dns_suffix}"

  type = "NS"
  ttl  = 300

  records = ["${local.name_servers}"]
}

resource "aws_route53_record" "wildcard_sys_dns" {
  zone_id = "${local.zone_id}"
  name    = "*.sys.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.web_elb.dns_name}"]
}

resource "aws_route53_record" "wildcard_apps_dns" {
  zone_id = "${local.zone_id}"
  name    = "*.apps.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.web_elb.dns_name}"]
}

resource "aws_route53_record" "ssh" {
  zone_id = "${local.zone_id}"
  name    = "ssh.sys.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.ssh_elb.dns_name}"]
}

resource "aws_route53_record" "tcp" {
  zone_id = "${local.zone_id}"
  name    = "tcp.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300

  records = ["${aws_elb.tcp_elb.dns_name}"]
}

resource "aws_route53_record" "wildcard_iso_dns" {
  zone_id = "${local.zone_id}"
  name    = "*.iso.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300
  count   = "${min(var.create_isoseg_resources,1)}"

  records = ["${aws_elb.isoseg.dns_name}"]
}
