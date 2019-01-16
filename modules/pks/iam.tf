resource "aws_iam_policy" "pks_master" {
  name   = "${var.env_name}_pks-master-policy"
  policy = "${file("${path.module}/policies/pks-master.json")}"
}

resource "aws_iam_role" "pks_master" {
  name = "${var.env_name}_pks-master"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "pks_master" {
  role       = "${aws_iam_role.pks_master.name}"
  policy_arn = "${aws_iam_policy.pks_master.arn}"
}

resource "aws_iam_instance_profile" "pks_master" {
  name = "${var.env_name}_pks-master"
  role = "${aws_iam_role.pks_master.name}"

  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "aws_iam_policy" "pks_worker" {
  name   = "${var.env_name}_pks-worker-policy"
  policy = "${file("${path.module}/policies/pks-worker.json")}"
}

resource "aws_iam_role" "pks_worker" {
  name = "${var.env_name}_pks-worker"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "pks_worker" {
  role       = "${aws_iam_role.pks_worker.name}"
  policy_arn = "${aws_iam_policy.pks_worker.arn}"
}

resource "aws_iam_instance_profile" "pks_worker" {
  name = "${var.env_name}_pks-worker"
  role = "${aws_iam_role.pks_worker.name}"

  lifecycle {
    ignore_changes = ["name"]
  }
}
