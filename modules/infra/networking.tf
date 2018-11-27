# Private Subnet ===============================================================

resource "aws_route_table" "private_route_table" {
  for_each = var.availability_zones
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_subnet" "infrastructure_subnets" {
  for_each = var.availability_zones
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.infrastructure_cidr, 2, each.key)}"
  availability_zone = "${element(var.availability_zones, each.key)}"

  tags = "${merge(var.tags, map("Name", "${var.env_name}-infrastructure-subnet${each.key}"))}"
}

data "template_file" "infrastructure_subnet_gateways" {
  # Render the template once for each availability zone
  for_each = var.availability_zones
  template = "$${gateway}"

  vars {
    gateway = "${cidrhost(element(aws_subnet.infrastructure_subnets.*.cidr_block, each.key), 1)}"
  }
}

resource "aws_route_table_association" "route_infrastructure_subnets" {
  for_each = var.availability_zones
  subnet_id      = "${element(aws_subnet.infrastructure_subnets.*.id, each.key)}"
  route_table_id = "${element(aws_route_table.private_route_table.*.id, each.key)}"
}

# Public Subnet ===============================================================

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${var.tags}"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = var.availability_zones
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.public_cidr, 2, each.key)}"
  availability_zone = "${element(var.availability_zones, each.key)}"

  tags = "${merge(var.tags, map("Name", "${var.env_name}-public-subnet${each.key}"))}"
}

resource "aws_route_table_association" "route_public_subnets" {
  for_each = var.availability_zones
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, each.key)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
