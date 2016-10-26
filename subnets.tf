resource "aws_subnet" "public_subnets" {
  count = "${length(var.availability_zones)}"
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet("10.0.0.0/22", 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-public-subnet${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = "${length(var.availability_zones)}"
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet("10.0.64.0/18", 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-private-subnet${count.index}"
  }
}

resource "aws_subnet" "rds_subnets" {
  count = "${length(var.availability_zones)}"
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet("10.0.128.0/22", 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-rds-subnet${count.index}"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env_name}_db_subnet_group"
  description = "RDS Subnet Group"

  subnet_ids = ["${aws_subnet.rds_subnets.*.id}"]

  tags {
    Name = "${var.env_name}-db-subnet-group"
  }
}
