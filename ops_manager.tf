resource "aws_instance" "ops_manager" {
  ami                    = "${var.ops_manager_ami}"
  instance_type          = "m3.medium"
  key_name               = "${aws_key_pair.ops_manager.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ops_manager_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${aws_subnet.public_subnets.0.id}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  tags {
    Name = "${var.env_name}-ops-manager"
  }
}

resource "aws_key_pair" "ops_manager" {
  key_name   = "${var.env_name}-ops-manager-key"
  public_key = "${tls_private_key.ops_manager.public_key_openssh}"
}

resource "aws_eip" "ops_manager_eip" {
  instance = "${aws_instance.ops_manager.id}"
  vpc      = true
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
