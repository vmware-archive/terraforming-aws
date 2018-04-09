locals {
  public_cidr     = "${cidrsubnet(var.vpc_cidr, 6, 0)}"
  management_cidr = "${cidrsubnet(var.vpc_cidr, 10, 64)}"
  pas_cidr        = "${cidrsubnet(var.vpc_cidr, 6, 1)}"
  services_cidr   = "${cidrsubnet(var.vpc_cidr, 6, 2)}"
  rds_cidr        = "${cidrsubnet(var.vpc_cidr, 6, 3)}"
}

resource "aws_subnet" "public_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.public_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-public-subnet${count.index}")
  )}"
}

resource "aws_subnet" "management_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.management_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-management-subnet${count.index}")
  )}"
}

resource "aws_subnet" "pas_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.pas_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "${var.env_name}-ert-subnet${count.index}"
  }
}

resource "aws_subnet" "services_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.services_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-services-subnet${count.index}")
  )}"
}

resource "aws_subnet" "rds_subnets" {
  count             = "${length(var.availability_zones)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(local.rds_cidr, 2, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-rds-subnet${count.index}")
  )}"
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env_name}_db_subnet_group"
  description = "RDS Subnet Group"

  subnet_ids = ["${aws_subnet.rds_subnets.*.id}"]

  tags = "${merge(var.tags, local.default_tags,
    map("Name", "${var.env_name}-db-subnet-group")
  )}"
}
