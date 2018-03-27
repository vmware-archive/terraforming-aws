resource "aws_iam_policy" "ops_manager_role" {
  name   = "${var.env_name}_ops_manager_role"
  policy = "${data.template_file.ops_manager.rendered}"
  count  = "${var.count}"
}

resource "aws_iam_role_policy_attachment" "ops_manager_policy" {
  role       = "${var.iam_role_name}"
  policy_arn = "${aws_iam_policy.ops_manager_role.arn}"
  count      = "${var.count}"
}

resource "aws_iam_policy" "ops_manager_user" {
  name   = "${var.env_name}_ops_manager_user"
  policy = "${data.template_file.ops_manager.rendered}"
  count  = "${var.count}"
}

resource "aws_iam_policy_attachment" "ops_manager" {
  name       = "${var.env_name}_om_policy_attachment"
  users      = ["${var.iam_user_name}"]
  policy_arn = "${aws_iam_policy.ops_manager_user.arn}"
  count      = "${var.count}"
}

data "template_file" "ops_manager" {
  template = "${file("${path.module}/templates/iam_policy.json")}"
  count    = "${var.count}"

  vars {
    iam_instance_profile_arn = "${var.instance_profile_arn}"
    iam_role_arn             = "${var.iam_role_arn}"
    ops_manager_bucket_arn   = "${aws_s3_bucket.ops_manager_bucket.arn}"
  }
}
