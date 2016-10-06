resource "aws_subnet" "public_subnet1" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.availability_zone1}"

  tags {
    Name = "${var.env_name}-public-subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.availability_zone2}"

  tags {
    Name = "${var.env_name}-public-subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.16.0/20"
  availability_zone = "${var.availability_zone1}"

  tags {
    Name = "${var.env_name}-private-subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.32.0/20"
  availability_zone = "${var.availability_zone2}"

  tags {
    Name = "${var.env_name}-private-subnet2"
  }
}

resource "aws_subnet" "rds_subnet1" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.availability_zone1}"

  tags {
    Name = "${var.env_name}-rds-subnet1"
  }
}

resource "aws_subnet" "rds_subnet2" {
  depends_on        = ["aws_vpc.vpc"]
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.availability_zone2}"

  tags {
    Name = "${var.env_name}-rds-subnet2"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.env_name}_db_subnet_group"
  description = "RDS Subnet Group"

  subnet_ids = [
    "${aws_subnet.rds_subnet1.id}",
    "${aws_subnet.rds_subnet2.id}",
  ]

  tags {
    Name = "${var.env_name}-db-subnet-group"
  }
}
