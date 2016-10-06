resource "aws_instance" "ops_manager" {
  depends_on             = ["aws_security_group.ops_manager_security_group", "aws_subnet.public_subnet1"]
  ami                    = "${var.ops_manager_ami}"
  instance_type          = "m3.medium"
  key_name               = "${var.nat_key_pair_name}"
  vpc_security_group_ids = ["${aws_security_group.ops_manager_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${aws_subnet.public_subnet1.id}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  tags {
    Name = "${var.env_name}-ops-manager"
  }
}

resource "aws_eip" "ops_manager_eip" {
  instance = "${aws_instance.ops_manager.id}"
  vpc      = true
}
