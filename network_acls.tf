resource "aws_network_acl" "isoseg" {
  count = "${var.create_isoseg_resources}"

  vpc_id     = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.isoseg_subnets.*.id}"]

  tags {
    Name = "${var.env_name}-isoseg"
  }
}

resource "aws_network_acl" "pas" {
  count = "${var.create_isoseg_resources}"

  vpc_id     = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.pas_subnets.*.id}"]

  tags {
    Name = "${var.env_name}-pas"
  }
}

resource "aws_network_acl" "bosh" {
  count = "${var.create_isoseg_resources}"

  vpc_id     = "${aws_vpc.vpc.id}"
  subnet_ids = ["${aws_subnet.management_subnets.*.id}"]

  tags {
    Name = "${var.env_name}-bosh"
  }
}

resource "aws_network_acl_rule" "isoseg-pas-ingress-1801" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.isoseg.id}"
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.pas_cidr}"
  from_port      = 1801
  to_port        = 1801
}

resource "aws_network_acl_rule" "isoseg-pas-ingress-8853" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.isoseg.id}"
  rule_number    = 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.pas_cidr}"
  from_port      = 8853
  to_port        = 8853
}

resource "aws_network_acl_rule" "isoseg-bosh-ingress" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.isoseg.id}"
  rule_number    = 117
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.management_cidr}"
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-3000" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 102
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 3000
  to_port        = 3000
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-3457" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 103
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 3457
  to_port        = 3457
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-4222" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 4222
  to_port        = 4222
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-4443" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 105
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 4443
  to_port        = 4443
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8080" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 106
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8080
  to_port        = 8080
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8082" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 107
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8082
  to_port        = 8082
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8300-8302" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 108
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8300
  to_port        = 8302
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8443" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 109
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8443
  to_port        = 8443
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8844" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 110
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8844
  to_port        = 8844
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8853" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 111
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8853
  to_port        = 8853
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8889" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 112
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8889
  to_port        = 8889
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-9022-9023" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 113
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 9022
  to_port        = 9023
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-9090-9091" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 114
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 9090
  to_port        = 9091
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8301-8302" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 115
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8301
  to_port        = 8302
}

resource "aws_network_acl_rule" "pas-isoseg-ingress-8600" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.pas.id}"
  rule_number    = 116
  egress         = false
  protocol       = "udp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 8600
  to_port        = 8600
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-22" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 118
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "bosh-opsman-ingress-22" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 130
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.public_cidr}"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-6868" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 119
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 6868
  to_port        = 6868
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-25555" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 120
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 25555
  to_port        = 25555
}

resource "aws_network_acl_rule" "bosh-opsman-ingress-25555" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 131
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.public_cidr}"
  from_port      = 25555
  to_port        = 25555
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-4222" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 121
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 4222
  to_port        = 4222
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-25250" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 122
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 25250
  to_port        = 25250
}

resource "aws_network_acl_rule" "bosh-isoseg-ingress-25777" {
  count = "${var.create_isoseg_resources}"

  network_acl_id = "${aws_network_acl.bosh.id}"
  rule_number    = 123
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "${var.isoseg_cidr}"
  from_port      = 25777
  to_port        = 25777
}
