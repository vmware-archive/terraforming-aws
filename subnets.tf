resource "aws_subnet" "public_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.public_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-public-subnet${count.index}"
  }
}

resource "aws_subnet" "management_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.management_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-management-subnet${count.index}"
  }
}

resource "aws_subnet" "pas_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.pas_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-ert-subnet${count.index}"
  }
}

resource "aws_subnet" "services_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.services_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-services-subnet${count.index}"
  }
}

resource "aws_subnet" "rds_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.rds_cidr, 2, count.index)}"
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

resource "aws_subnet" "isoseg_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(var.isoseg_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-isoseg-subnet${count.index}"
  }
}
