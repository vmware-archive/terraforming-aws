resource "aws_eip" "ops_manager_attached" {
  instance = "${aws_instance.ops_manager.id}"
  count    = "${var.private ? 0 : local.ops_man_vm }"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-om-eip"))}"
}

resource "aws_eip" "ops_manager_unattached" {
  count = "${var.private || (local.ops_man_vm > 0) ? 0 : 1}"
  vpc   = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-om-eip"))}"
}

resource "aws_eip" "optional_ops_manager" {
  instance = "${aws_instance.optional_ops_manager.id}"
  count    = "${var.private ? 0 : local.optional_ops_man_vm}"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-optional-om-eip"))}"
}
