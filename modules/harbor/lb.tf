// Allow access to Harbor Registry and Notary
resource "aws_security_group" "harbor_lb_security_group" {
  name        = "harbor_lb_security_group"
  description = "Harbor LB Security Group"
  vpc_id      = "${var.vpc_id}"

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

  tags = "${merge(var.tags, map("Name", "${var.env_name}-harbor-lb-security-group"))}"
}

resource "aws_lb" "harbor" {
  name                             = "${var.env_name}-harbor"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = ["${var.public_subnet_ids}"]
}

resource "aws_lb_listener" "harbor_443" {
  load_balancer_arn = "${aws_lb.harbor.arn}"
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.harbor_443.arn}"
  }
}

resource "aws_lb_target_group" "harbor_443" {
  name     = "${var.env_name}-harbor-tg-443"
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

resource "aws_lb_listener" "harbor_4443" {
  load_balancer_arn = "${aws_lb.harbor.arn}"
  port              = 4443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.harbor_4443.arn}"
  }
}

resource "aws_lb_target_group" "harbor_4443" {
  name     = "${var.env_name}-harbor-tg-4443"
  port     = 8443
  protocol = "TCP"
  vpc_id   = "${var.vpc_id}"
}
