data "template_file" "ops_manager" {
  template = "${file("${path.module}/templates/iam_policy.json")}"

  vars {
    iam_instance_profile_arn = "${aws_iam_instance_profile.ops_manager.arn}"
    ops_manager_bucket_arn   = "${aws_s3_bucket.ops_manager_bucket.arn}"
    iam_ops_manager_role_arn = "${aws_iam_role.ops_manager.arn}"
  }
}

data "aws_iam_policy_document" "ops_manager" {
  source_json = "${data.template_file.ops_manager.rendered}"

  statement {
    sid     = "AllowToCreateInstanceWithCurrentInstanceProfile"
    effect  = "Allow"
    actions = ["iam:PassRole"]

    resources = [
      "${compact(concat(list(aws_iam_role.ops_manager.arn), var.additional_iam_roles_arn))}",
    ]
  }

  statement {
    sid     = "AllowOperationsForCreatingOpsMan"
    effect  = "Allow"
    actions = ["ec2:ModifyVolume", "ec2:StopInstances", "ec2:StartInstances"]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "ops_manager_role" {
  name   = "${var.env_name}_ops_manager_role"
  policy = "${data.aws_iam_policy_document.ops_manager.json}"
}

resource "aws_iam_role_policy_attachment" "ops_manager_policy" {
  role       = "${aws_iam_role.ops_manager.name}"
  policy_arn = "${aws_iam_policy.ops_manager_role.arn}"
}

resource "aws_iam_policy" "ops_manager_user" {
  name   = "${var.env_name}_ops_manager_user"
  policy = "${data.aws_iam_policy_document.ops_manager.json}"

  count = "${var.iam_users}"
}

resource "aws_iam_user_policy_attachment" "ops_manager" {
  user       = "${aws_iam_user.ops_manager.name}"
  policy_arn = "${aws_iam_policy.ops_manager_user.arn}"

  count = "${var.iam_users}"
}

resource "aws_iam_user" "ops_manager" {
  name = "${var.env_name}_om_user"

  count = "${var.iam_users}"
}

resource "aws_iam_access_key" "ops_manager" {
  user = "${aws_iam_user.ops_manager.name}"

  count = "${var.iam_users}"
}

resource "aws_iam_role" "ops_manager" {
  name = "${var.env_name}_om_role"

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

resource "aws_iam_instance_profile" "ops_manager" {
  name = "${var.env_name}_ops_manager"
  role = "${aws_iam_role.ops_manager.name}"

  lifecycle {
    ignore_changes = ["name"]
  }
}
