resource "aws_instance" "ops_manager" {
  ami                    = "${var.ops_manager_ami}"
  instance_type          = "m3.large"
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

resource "aws_instance" "optional_ops_manager" {
  ami                    = "${var.optional_ops_manager_ami}"
  instance_type          = "m3.large"
  key_name               = "${aws_key_pair.ops_manager.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ops_manager_security_group.id}"]
  source_dest_check      = false
  subnet_id              = "${aws_subnet.public_subnets.0.id}"
  count                  = "${min(length(split("", var.optional_ops_manager_ami)),1)}"

  root_block_device {
    volume_type = "gp2"
    volume_size = 50
  }

  tags {
    Name = "${var.env_name}-optional-ops-manager"
  }
}

resource "aws_key_pair" "ops_manager" {
  key_name   = "${var.env_name}-ops-manager-key"
  public_key = "${tls_private_key.ops_manager.public_key_openssh}"
}

resource "aws_eip" "ops_manager" {
  instance = "${aws_instance.ops_manager.id}"
  vpc      = true
}

resource "aws_eip" "optional_ops_manager" {
  instance = "${aws_instance.optional_ops_manager.id}"
  count    = "${min(length(split("", var.optional_ops_manager_ami)),1)}"
  vpc      = true
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
