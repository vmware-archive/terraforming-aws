resource "aws_route53_zone" "pcf_zone" {
  name = "${var.env_name}.${var.dns_suffix}"

  tags {
    Name = "${var.env_name}-hosted-zone"
  }
}

resource "aws_route53_record" "ops_manager" {
  zone_id = "${aws_route53_zone.pcf_zone.id}"
  name    = "pcf.${var.env_name}.${var.dns_suffix}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.ops_manager_eip.public_ip}"]
}

resource "aws_route53_record" "wildcard" {
  zone_id = "${aws_route53_zone.pcf_zone.id}"
  name    = "*.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${aws_elb.web_elb.dns_name}"]
}

resource "aws_route53_record" "ssh" {
  zone_id = "${aws_route53_zone.pcf_zone.id}"
  name    = "ssh.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${aws_elb.ssh_elb.dns_name}"]
}

resource "aws_route53_record" "tcp" {
  zone_id = "${aws_route53_zone.pcf_zone.id}"
  name    = "tcp.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = "5"
  records = ["${aws_elb.tcp_elb.dns_name}"]
}
