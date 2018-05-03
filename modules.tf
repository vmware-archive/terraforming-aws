module "ops_manager" {
  source = "./ops_manager"

  count          = "${var.ops_manager ? 1 : 0}"
  optional_count = "${var.optional_ops_manager ? 1 : 0}"

  env_name              = "${var.env_name}"
  ami                   = "${var.ops_manager_ami}"
  optional_ami          = "${var.optional_ops_manager_ami}"
  instance_type         = "${var.ops_manager_instance_type}"
  subnet_id             = "${aws_subnet.public_subnets.0.id}"
  vpc_id                = "${aws_vpc.vpc.id}"
  dns_suffix            = "${var.dns_suffix}"
  zone_id               = "${local.zone_id}"
  iam_user_name         = "${aws_iam_user.ops_manager.name}"
  iam_role_name         = "${aws_iam_role.ops_manager.name}"
  iam_role_arn          = "${aws_iam_role.ops_manager.arn}"
  bucket_suffix         = "${local.bucket_suffix}"
  instance_profile_name = "${aws_iam_instance_profile.ops_manager.name}"
  instance_profile_arn  = "${aws_iam_instance_profile.ops_manager.arn}"
  tags                  = "${var.tags}"
  default_tags          = "${local.default_tags}"
}
