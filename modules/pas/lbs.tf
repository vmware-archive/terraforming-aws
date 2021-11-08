resource "aws_security_group" "bosh_elb" {
  name        = "bosh_elb_security_group"
  description = "Load Balancer Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 25555
    to_port     = 25555
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 8443
    to_port     = 8443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 8844
    to_port     = 8844
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-lb-security-group"))}"
}

resource "aws_elb" "bosh" {
  name                             = "${var.env_name}-bosh-elb"
  cross_zone_load_balancing        = true
  subnets                          = ["${var.public_subnet_ids}"]
  security_groups = ["${aws_security_group.bosh_elb.id}"]

  listener {
    instance_port = 25555
    instance_protocol = "TCP"
    lb_port = 25555
    lb_protocol = "TCP"
  }

  listener {
    instance_port = 8443
    instance_protocol = "TCP"
    lb_port = 8443
    lb_protocol = "TCP"
  }

  listener {
    instance_port = 8844
    instance_protocol = "TCP"
    lb_port = 8844
    lb_protocol = "TCP"
  }

  health_check {
    target = "TCP:22"
    timeout = 2
    interval = 5
    unhealthy_threshold = 5
    healthy_threshold = 2
  }
}

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
  count       = "${var.use_ssh_routes ? 1 : 0}"
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
  count                            = "${var.use_ssh_routes ? 1 : 0}"
  name                             = "${var.env_name}-ssh-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = "${var.internetless}"
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "ssh" {
  count             = "${var.use_ssh_routes ? 1 : 0}"
  load_balancer_arn = "${aws_lb.ssh.arn}"
  port              = 2222
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ssh.arn}"
  }
}

resource "aws_lb_target_group" "ssh" {
  count    = "${var.use_ssh_routes ? 1 :0}"
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
  tcp_port_count = "${var.use_tcp_routes ? 10 : 0}"
}

resource "aws_security_group" "tcp_lb" {
  count       = "${var.use_tcp_routes ? 1 : 0}"
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
  count                            = "${var.use_tcp_routes ? 1 : 0}"
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
  name     = "${var.env_name}-tcp-tg-${1024 + count.index}"
  port     = "${1024 + count.index}"
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  count = "${local.tcp_port_count}"

  health_check {
    protocol = "TCP"
  }
}
