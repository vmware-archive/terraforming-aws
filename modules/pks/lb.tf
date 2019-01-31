// Allow access to PKS API
resource "aws_security_group" "pks_api_lb_security_group" {
  name        = "pks_api_lb_security_group"
  description = "PKS API LB Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 9021
    to_port     = 9021
  }

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

  tags = "${merge(var.tags, map("Name", "${var.env_name}-pks-api-lb-security-group"))}"
}

resource "aws_lb" "pks_api" {
  name                             = "${var.env_name}-pks-api"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "pks_api_9021" {
  load_balancer_arn = "${aws_lb.pks_api.arn}"
  port              = 9021
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.pks_api_9021.arn}"
  }
}

resource "aws_lb_target_group" "pks_api_9021" {
  name     = "${var.env_name}-pks-tg-9021"
  port     = 9021
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "pks_api_8443" {
  load_balancer_arn = "${aws_lb.pks_api.arn}"
  port              = 8443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.pks_api_8443.arn}"
  }
}

resource "aws_lb_target_group" "pks_api_8443" {
  name     = "${var.env_name}-pks-tg-8443"
  port     = 8443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}
