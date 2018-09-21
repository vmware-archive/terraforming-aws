resource "aws_instance" "optional_ops_manager" {
  ami                    = "${var.optional_ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.ops_manager.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ops_manager_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${var.subnet_id}"
  iam_instance_profile   = "${aws_iam_instance_profile.ops_manager.name}"
  count                  = "${var.optional_count}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 150
  }

  tags = "${merge(var.tags, map("Name", "${var.env_name}-optional-ops-manager"))}"
}
