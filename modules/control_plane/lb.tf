// Allow access to Web VM
resource "aws_security_group" "control_plane" {
  name        = "control_plane_security_group"
  description = "Control Plane LB Security Group"
  vpc_id      = "${var.vpc_id}"

  # ATC (Web Server)
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  # UAA
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 8443
    to_port     = 8443
  }

  # TSA
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 2222
    to_port     = 2222
  }

  # CredHub
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

  tags = "${merge(var.tags, map("Name", "${var.env_name}-control-plane-security-group"))}"
}

resource "aws_lb" "control_plane" {
  name                             = "${var.env_name}-control-plane-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "atc_http" {
  load_balancer_arn = "${aws_lb.control_plane.arn}"
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.atc_http.arn}"
  }
}

resource "aws_lb_target_group" "atc_http" {
  name     = "${var.env_name}-atc-http-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "atc_https" {
  load_balancer_arn = "${aws_lb.control_plane.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.atc_https.arn}"
  }
}

resource "aws_lb_target_group" "atc_https" {
  name     = "${var.env_name}-atc-https-tg"
  port     = 443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "uaa" {
  load_balancer_arn = "${aws_lb.control_plane.arn}"
  port              = 8443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.uaa.arn}"
  }
}

resource "aws_lb_target_group" "uaa" {
  name     = "${var.env_name}-uaa-tg"
  port     = 8443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "tsa" {
  load_balancer_arn = "${aws_lb.control_plane.arn}"
  port              = 2222
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.tsa.arn}"
  }
}

resource "aws_lb_target_group" "tsa" {
  name     = "${var.env_name}-tsa-tg"
  port     = 2222
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "credhub" {
  load_balancer_arn = "${aws_lb.control_plane.arn}"
  port              = 8844
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.credhub.arn}"
  }
}

resource "aws_lb_target_group" "credhub" {
  name     = "${var.env_name}-credhub-tg"
  port     = 8844
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}
