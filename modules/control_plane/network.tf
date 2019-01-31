resource "aws_subnet" "control_plane" {
  count             = "${length(var.availability_zones)}"
  cidr_block        = "${cidrsubnet(local.control_plane_cidr, 4, count.index)}"
  vpc_id            = "${var.vpc_id}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-control-plane-subnet${count.index}"
  }
}

data "template_file" "subnet_gateways" {
  # Render the template once for each availability zone
  count    = "${length(var.availability_zones)}"
  template = "$${gateway}"

  vars {
    gateway = "${cidrhost(element(aws_subnet.control_plane.*.cidr_block, count.index), 1)}"
  }
}

resource "aws_route_table_association" "route_control_plane_subnets" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.control_plane.*.id, count.index)}"
  route_table_id = "${element(var.private_route_table_ids, count.index)}"
}

// Allow open access between internal VMs for a Control Plane deployment
resource "aws_security_group" "control_plane_internal" {
  name        = "control_plane_internal_security_group"
  description = "Control Plane Internal Security Group"
  vpc_id      = "${var.vpc_id}"

  ingress {
    cidr_blocks = ["${local.control_plane_cidr}"]
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["${local.control_plane_cidr}"]
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["${local.control_plane_cidr}"]
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

  tags = "${merge(var.tags, map("Name", "${var.env_name}-control-plane-internal-security-group"))}"
}
