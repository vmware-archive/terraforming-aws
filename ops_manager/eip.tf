resource "aws_eip" "ops_manager" {
  instance = "${aws_instance.ops_manager.id}"
  count    = "${var.count}"
  vpc      = true
}

resource "aws_eip" "upgrade_ops_manager" {
  instance = "${aws_instance.upgrade_ops_manager.id}"
  count    = "${var.upgrade_count}"
  vpc      = true
}
