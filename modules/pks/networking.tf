resource "aws_subnet" "pks_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(local.pks_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-pks-subnet${count.index}"
  }
}

data "template_file" "pks_subnet_gateways" {
  # Render the template once for each availability zone
  count    = "${length(var.availability_zones)}"
  template = "$${gateway}"

  vars {
    gateway = "${cidrhost(element(aws_subnet.pks_subnets.*.cidr_block, count.index), 1)}"
  }
}

resource "aws_route_table_association" "route_pks_subnets" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.pks_subnets.*.id, count.index)}"
  route_table_id = "${element(var.private_route_table_ids, count.index)}"
}

resource "aws_subnet" "services_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${cidrsubnet(local.pks_services_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, map("Name", "${var.env_name}-pks-services-subnet${count.index}"), 
      map("kubernetes.io/role/internal-elb", "1"), 
      map("SubnetType", "Private"))}"

  # Ignore additional tags that are added for specifying clusters.
  lifecycle {
    ignore_changes = ["tags.%", "tags.kubernetes"]
  }
}

data "template_file" "services_subnet_gateways" {
  # Render the template once for each availability zone
  count    = "${length(var.availability_zones)}"
  template = "$${gateway}"

  vars {
    gateway = "${cidrhost(element(aws_subnet.services_subnets.*.cidr_block, count.index), 1)}"
  }
}

resource "aws_route_table_association" "route_services_subnets" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.services_subnets.*.id, count.index)}"
  route_table_id = "${element(var.private_route_table_ids, count.index)}"
}

// Allow open access between internal VMs for a PKS deployment
resource "aws_security_group" "pks_internal_security_group" {
  name        = "pks_internal_security_group"
  description = "PKS Internal Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["${local.pks_cidr}", "${local.pks_services_cidr}"]
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["${local.pks_cidr}", "${local.pks_services_cidr}"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["${local.pks_cidr}", "${local.pks_services_cidr}"]
    protocol    = "udp"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-pks-internal-security-group"))}"
}

// Allow access to master nodes
resource "aws_security_group" "pks_master_security_group" {
  name        = "pks_master"
  description = "PKS Master Node Security Group"
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

  tags = "${merge(var.tags, map("Name", "${var.env_name}-pks-master-security-group"))}"
}
