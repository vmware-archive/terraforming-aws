resource "aws_iam_user" "iam_user" {
  name = "${var.env_name}_iam_user"
}

resource "aws_iam_access_key" "iam_user_access_key" {
  user = "${aws_iam_user.iam_user.name}"
}

resource "aws_iam_role" "iam_role" {
  name = "${var.env_name}_iam_role"

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
  roles = ["${aws_iam_role.iam_role.name}"]
}

data "template_file" "ops_manager" {
  template = "${file("${path.root}/templates/iam_ops_manager_policy.json")}"

  vars {
    iam_instance_profile_arn = "${aws_iam_instance_profile.iam_instance_profile.arn}"
    iam_role_arn             = "${aws_iam_role.iam_role.arn}"
    ops_manager_bucket_arn   = "${aws_s3_bucket.ops_manager_bucket.arn}"
  }
}

data "template_file" "ert" {
  template = "${file("${path.root}/templates/iam_ert_buckets_policy.json")}"

  vars {
    buildpacks_bucket_arn = "${aws_s3_bucket.buildpacks_bucket.arn}"
    droplets_bucket_arn   = "${aws_s3_bucket.droplets_bucket.arn}"
    packages_bucket_arn   = "${aws_s3_bucket.packages_bucket.arn}"
    resources_bucket_arn  = "${aws_s3_bucket.resources_bucket.arn}"
  }
}

resource "aws_iam_policy" "ops_manager" {
  name   = "${var.env_name}_ops_manager"
  policy = "${data.template_file.ops_manager.rendered}"
}

resource "aws_iam_policy" "ert" {
  name   = "${var.env_name}_ert"
  policy = "${data.template_file.ert.rendered}"
}

resource "aws_iam_policy_attachment" "ops_manager_user_policy" {
  name       = "${var.env_name}_iam_user_policy"
  users      = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.ops_manager.arn}"
}

resource "aws_iam_policy_attachment" "ert_user_policy" {
  name       = "${var.env_name}_iam_user_policy"
  users      = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.ert.arn}"
}
