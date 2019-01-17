# Web Load Balancer

resource "aws_security_group" "web_lb" {
  name        = "web_lb_security_group"
  description = "Load Balancer Security Group"
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

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-lb-security-group"))}"
}

resource "aws_lb" "web" {
  name                             = "${var.env_name}-web-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = "${var.internetless}"
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "web_80" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_80.arn}"
  }
}

resource "aws_lb_listener" "web_443" {
  load_balancer_arn = "${aws_lb.web.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_443.arn}"
  }
}

resource "aws_lb_target_group" "web_80" {
  name     = "${var.env_name}-web-tg-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }
}

resource "aws_lb_target_group" "web_443" {
  name     = "${var.env_name}-web-tg-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }
}

# SSH Load Balancer

resource "aws_security_group" "ssh_lb" {
  name        = "ssh_lb_security_group"
  description = "Load Balancer SSH Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 2222
    to_port     = 2222
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-ssh-lb-security-group"))}"
}

resource "aws_lb" "ssh" {
  name                             = "${var.env_name}-ssh-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = "${var.internetless}"
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "ssh" {
  load_balancer_arn = "${aws_lb.ssh.arn}"
  port              = 2222
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ssh.arn}"
  }
}

resource "aws_lb_target_group" "ssh" {
  name     = "${var.env_name}-ssh-tg"
  port     = 2222
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    protocol = "TCP"
  }
}

# TCP Load Balancer

locals {
  tcp_port_count = 10
}

resource "aws_security_group" "tcp_lb" {
  name        = "tcp_lb_security_group"
  description = "Load Balancer TCP Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 1024
    to_port     = "${1024 + local.tcp_port_count}"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-tcp-lb-security-group"))}"
}

resource "aws_lb" "tcp" {
  name                             = "${var.env_name}-tcp-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = "${var.internetless}"
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = "${aws_lb.tcp.arn}"
  port              = "${1024 + count.index}"
  protocol          = "TCP"

  count = "${local.tcp_port_count}"

  default_action {
    type             = "forward"
    target_group_arn = "${element(aws_lb_target_group.tcp.*.arn, count.index)}"
  }
}

resource "aws_lb_target_group" "tcp" {
  name     = "${var.env_name}-tg-${1024 + count.index}"
  port     = "${1024 + count.index}"
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  count = "${local.tcp_port_count}"

  health_check {
    protocol = "TCP"
  }
}
