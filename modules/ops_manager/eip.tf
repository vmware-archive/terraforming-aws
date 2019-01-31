resource "aws_eip" "ops_manager_attached" {
  instance = "${aws_instance.ops_manager.id}"
  count    = "${var.private ? 0 : var.vm_count}"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-om-eip"))}"
}

resource "aws_eip" "ops_manager_unattached" {
  count = "${var.private || (var.vm_count > 0) ? 0 : 1}"
  vpc   = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-om-eip"))}"
}

resource "aws_eip" "optional_ops_manager" {
  instance = "${aws_instance.optional_ops_manager.id}"
  count    = "${var.private ? 0 : var.optional_count}"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-optional-om-eip"))}"
}
