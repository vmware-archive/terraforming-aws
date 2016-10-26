resource "aws_route_table" "public_route_table" {
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_internet_gateway.ig"]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }
}

resource "aws_route_table_association" "route_public_subnets" {
  count = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table" "private_route_tables" {
  count = "${length(var.availability_zones)}"
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_subnet.private_subnets"]

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "route_private_subnets" {
  count = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private_route_tables.*.id, count.index)}"
}