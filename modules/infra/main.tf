resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-vpc"))}"
}

resource "aws_security_group" "vms_security_group" {
  name        = "vms_security_group"
  description = "VMs Security Group"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-vms-security-group"))}"
}

resource "aws_security_group" "nat_security_group" {
  name        = "nat_security_group"
  description = "NAT Security Group"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    cidr_blocks = ["${var.vpc_cidr}"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-nat-security-group"))}"
}

resource "aws_instance" "nat" {
  ami                    = "${lookup(var.nat_ami_map, var.region)}"
  instance_type          = "t2.medium"
  vpc_security_group_ids = ["${aws_security_group.nat_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${element(aws_subnet.public_subnets.*.id, 0)}"

  tags = "${merge(var.tags, map("Name", "${var.env_name}-nat"))}"
}

resource "aws_eip" "nat_eip" {
  instance = "${aws_instance.nat.id}"
  vpc      = true

  tags = "${var.tags}"
}
