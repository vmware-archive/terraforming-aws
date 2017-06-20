resource "aws_security_group" "ops_manager_security_group" {
  name        = "ops_manager_security_group"
  description = "Ops Manager Security Group"
  vpc_id      = "${var.vpc_id}"
  count       = "${var.count}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

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
    cidr_blocks = ["10.0.0.0/16"]
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    protocol    = "tcp"
    from_port   = 25555
    to_port     = 25555
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]
    protocol    = "tcp"
    from_port   = 6868
    to_port     = 6868
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags {
    Name = "${var.env_name}-ops-manager-security-group"
  }
}
