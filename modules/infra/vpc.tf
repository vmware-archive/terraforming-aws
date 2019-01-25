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

locals {
  ec2_address = "com.amazonaws.${var.region}.ec2"
  lb_api_address = "com.amazonaws.${var.region}.elasticloadbalancing"
}

resource "aws_vpc_endpoint" "ec2" {
  count = "${var.internetless ? 1 : 0}"

  vpc_id              = "${aws_vpc.vpc.id}"
  service_name        = "${local.ec2_address}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = ["${aws_subnet.infrastructure_subnets.*.id}"]
  private_dns_enabled = true
  security_group_ids  = ["${aws_security_group.vms_security_group.id}"]
}

resource "aws_vpc_endpoint" "lb" {
  count = "${var.internetless ? 1 : 0}"

  vpc_id              = "${aws_vpc.vpc.id}"
  service_name        = "${local.lb_api_address}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = ["${aws_subnet.infrastructure_subnets.*.id}"]
  private_dns_enabled = true
  security_group_ids  = ["${aws_security_group.vms_security_group.id}"]
}

data "aws_network_interface" "ec2_endpoints" {
  count = "${var.internetless ? length(var.availability_zones) : 0}"

  id = "${element(aws_vpc_endpoint.ec2.0.network_interface_ids, count.index)}"
}

data "aws_network_interface" "lb_endpoints" {
  count = "${var.internetless ? length(var.availability_zones) : 0}"

  id = "${element(aws_vpc_endpoint.lb.0.network_interface_ids, count.index)}"
}
