resource "aws_route_table" "public_route_table" {
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_internet_gateway.ig"]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }
}

resource "aws_route_table_association" "route_public_subnet1" {
  subnet_id      = "${aws_subnet.public_subnet1.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table_association" "route_public_subnet2" {
  subnet_id      = "${aws_subnet.public_subnet2.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}

resource "aws_route_table" "private_route_table1" {
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_subnet.private_subnet1"]

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table" "private_route_table2" {
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_subnet.private_subnet2"]

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "route_private_subnet1" {
  subnet_id      = "${aws_subnet.private_subnet1.id}"
  route_table_id = "${aws_route_table.private_route_table1.id}"
}

resource "aws_route_table_association" "route_private_subnet2" {
  subnet_id      = "${aws_subnet.private_subnet2.id}"
  route_table_id = "${aws_route_table.private_route_table2.id}"
}
