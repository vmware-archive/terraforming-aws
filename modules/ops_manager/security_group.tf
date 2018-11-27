resource "aws_security_group" "ops_manager_security_group" {
  name        = "ops_manager_security_group"
  description = "Ops Manager Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["${var.private ? var.vpc_cidr : "0.0.0.0/0"}"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["${var.private ? var.vpc_cidr : "0.0.0.0/0"}"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["${var.private ? var.vpc_cidr : "0.0.0.0/0"}"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["${var.private ? var.vpc_cidr : "0.0.0.0/0"}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-ops-manager-security-group"))}"
}
