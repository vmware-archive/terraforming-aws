resource "aws_eip" "ops_manager" {
  instance = "${aws_instance.ops_manager.id}"
  count    = "${var.private ? 0 : var.count}"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-om-eip"))}"
}

resource "aws_eip" "optional_ops_manager" {
  instance = "${aws_instance.optional_ops_manager.id}"
  count    = "${var.private ? 0 : var.optional_count}"
  vpc      = true

  tags = "${merge(var.tags, map("Name", "${var.env_name}-optional-om-eip"))}"
}
