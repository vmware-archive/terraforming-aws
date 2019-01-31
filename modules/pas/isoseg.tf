resource "aws_security_group" "isoseg_lb_security_group" {
  count = "${var.create_isoseg_resources}"

  name        = "isoseg_lb_security_group"
  description = "Isoseg Load Balancer Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 4443
    to_port     = 4443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-isoseg-lb-security-group"))}"
}

resource "aws_lb" "isoseg" {
  count = "${var.create_isoseg_resources}"

  name                             = "${var.env_name}-isoseg-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = ["${var.public_subnet_ids}"]

  tags = "${var.tags}"
}

resource "aws_lb_listener" "isoseg_80" {
  load_balancer_arn = "${aws_lb.isoseg.arn}"
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.isoseg_80.arn}"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_lb_listener" "isoseg_443" {
  load_balancer_arn = "${aws_lb.isoseg.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.isoseg_443.arn}"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_lb_listener" "isoseg_4443" {
  load_balancer_arn = "${aws_lb.isoseg.arn}"
  port              = 4443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.isoseg_4443.arn}"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_lb_target_group" "isoseg_80" {
  name     = "${var.env_name}-iso-tg-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_lb_target_group" "isoseg_443" {
  name     = "${var.env_name}-iso-tg-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_lb_target_group" "isoseg_4443" {
  name     = "${var.env_name}-iso-tg-4443"
  port     = 4443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }

  count = "${var.create_isoseg_resources}"
}

resource "aws_route53_record" "wildcard_iso_dns" {
  zone_id = "${var.zone_id}"
  name    = "*.iso.${var.env_name}.${var.dns_suffix}"
  type    = "CNAME"
  ttl     = 300
  count   = "${var.create_isoseg_resources}"

  records = ["${aws_lb.isoseg.dns_name}"]
}
