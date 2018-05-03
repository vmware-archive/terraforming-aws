data "aws_route53_zone" "pcf_zone" {
  name = "${var.dns_suffix}"
}

locals {
  zone_id = "${data.aws_route53_zone.pcf_zone.zone_id == "" ? element(concat(aws_route53_zone.pcf_zone.*.zone_id, list("")), 0) : data.aws_route53_zone.pcf_zone.zone_id}"

  data_dns_nameservers     = "${join(",", data.aws_route53_zone.pcf_zone.name_servers)}"
  resource_dns_nameservers = "${join(",", concat(aws_route53_zone.pcf_zone.*.name_servers, list("")))}"
}

resource "aws_route53_zone" "pcf_zone" {
  name = "${var.env_name}.${var.dns_suffix}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-hosted-zone")
  )}"

  count = "${data.aws_route53_zone.pcf_zone.zone_id == "" ? 1 : 0}"
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
