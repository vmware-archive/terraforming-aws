module "ops_manager" {
  source = "./ops_manager"

  count          = "${var.ops_manager ? 1 : 0}"
  optional_count = "${var.optional_ops_manager ? 1 : 0}"

  env_name      = "${var.env_name}"
  ami           = "${var.ops_manager_ami}"
  optional_ami  = "${var.optional_ops_manager_ami}"
  instance_type = "${var.ops_manager_instance_type}"
  subnet_id     = "${aws_subnet.public_subnets.0.id}"
  vpc_id        = "${aws_vpc.vpc.id}"
  dns_suffix    = "${var.dns_suffix}"
  zone_id       = "${aws_route53_zone.pcf_zone.id}"
  iam_user_name = "${aws_iam_user.iam_user.name}"
}
