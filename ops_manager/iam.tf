resource "aws_iam_policy" "ops_manager" {
  name   = "${var.env_name}_ops_manager"
  policy = "${data.template_file.ops_manager.rendered}"
  count  = "${var.count}"
}

resource "aws_iam_policy_attachment" "ops_manager_user_policy" {
  name       = "${var.env_name}_iam_user_policy"
  users      = ["${var.iam_user_name}"]
  policy_arn = "${aws_iam_policy.ops_manager.arn}"
  count      = "${var.count}"
}

resource "aws_iam_role" "iam_role" {
  name  = "${var.env_name}_iam_role"
  count = "${var.count}"

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

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name  = "${var.env_name}_iam_instance_profile"
  count = "${var.count}"
  role  = "${aws_iam_role.iam_role.name}"
}

data "template_file" "ops_manager" {
  template = "${file("${path.module}/templates/iam_policy.json")}"

  vars {
    iam_instance_profile_arn = "${aws_iam_instance_profile.iam_instance_profile.arn}"
    iam_role_arn             = "${aws_iam_role.iam_role.arn}"
    ops_manager_bucket_arn   = "${aws_s3_bucket.ops_manager_bucket.arn}"
  }
}
