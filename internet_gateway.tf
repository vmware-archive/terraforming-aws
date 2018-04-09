resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = "${merge(var.tags, local.default_tags)}"
}
