resource "aws_security_group" "credhub" {
  name        = "${var.env_name}-credhub-sg"
  description = "Allows users to access the credhub"
  vpc_id      = "${var.vpc_id}"

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

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_security_group" "uaa" {
  name        = "${var.env_name}-uaa-sg"
  description = "Allows users to access the uaa"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 8443
    to_port     = 8443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_security_group" "lb" {
  name        = "${var.env_name}-alb-sg"
  description = "Allow access to VMs from LB"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol        = "tcp"
    security_groups = ["${aws_security_group.uaa.id}"]
    from_port       = 8443
    to_port         = 8443
  }

  egress {
    protocol        = "tcp"
    security_groups = ["${aws_security_group.credhub.id}"]
    from_port       = 8844
    to_port         = 8844
  }

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_lb" "credhub_uaa" {
  count              = "${var.use_alb}"
  name               = "${var.env_name}-shared-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${var.public_subnet_ids}"]
  security_groups    = ["${aws_security_group.lb.id}"]

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_lb" "credhub_lb" {
  count              = "${var.use_alb ? 0 : 1}"
  name               = "${var.env_name}-credhub-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${var.public_subnet_ids}"]

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_lb" "uaa_lb" {
  count              = "${var.use_alb ? 0 : 1}"
  name               = "${var.env_name}-uaa-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${var.public_subnet_ids}"]

  tags = {
    Environment = "${var.env_name}"
  }
}

resource "aws_lb_target_group" "uaa" {
  count    = "${var.use_alb}"
  name     = "${var.env_name}-uaa-tg"
  port     = 8443
  protocol = "HTTPS"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    port                = 8080
    protocol            = "HTTP"
    path                = "/healthz"
  }
}

resource "aws_lb_target_group" "credhub" {
  count    = "${var.use_alb}"
  name     = "${var.env_name}-credhub-tg"
  port     = 8844
  protocol = "HTTPS"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 30
    port                = 8844
    protocol            = "HTTPS"
    path                = "/health"
  }
}

resource "aws_lb_listener" "credhub_uaa" {
  count             = "${var.use_alb}"
  load_balancer_arn = "${aws_lb.credhub_uaa.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = "${aws_iam_server_certificate.lb_managed_cert.arn}"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "404"
      message_body = "you can only connect to uaa or credhub from this load balancer"
    }
  }
}

resource "aws_lb_listener_rule" "redirect_to_uaa" {
  count        = "${var.use_alb}"
  listener_arn = "${aws_lb_listener.credhub_uaa.arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.uaa.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${aws_route53_record.uaa.name}"]
  }
}

resource "aws_lb_listener_rule" "redirect_to_credhub" {
  count        = "${var.use_alb}"
  listener_arn = "${aws_lb_listener.credhub_uaa.arn}"

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.credhub.arn}"
  }

  condition {
    field  = "host-header"
    values = ["${aws_route53_record.credhub.name}"]
  }
}

resource "aws_lb_listener" "uaa" {
  count             = "${var.use_alb ? 0 : 1}"
  load_balancer_arn = "${aws_lb.uaa_lb.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.uaa_tcp.arn}"
  }
}

resource "aws_lb_target_group" "uaa_tcp" {
  count    = "${var.use_alb ? 0 : 1}"
  name     = "${var.env_name}-uaa-https-tg"
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

resource "aws_lb_listener" "credhub" {
  count             = "${var.use_alb ? 0 : 1}"
  load_balancer_arn = "${aws_lb.credhub_lb.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.credhub_tcp.arn}"
  }
}

resource "aws_lb_target_group" "credhub_tcp" {
  count    = "${var.use_alb ? 0 : 1}"
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
