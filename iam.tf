resource "aws_iam_user" "iam_user" {
  name = "${var.env_name}_iam_user"
}

resource "aws_iam_access_key" "iam_user_access_key" {
  user = "${aws_iam_user.iam_user.name}"
}

data "template_file" "ert" {
  template = "${file("${path.module}/templates/iam_pas_buckets_policy.json")}"

  vars {
    buildpacks_bucket_arn = "${aws_s3_bucket.buildpacks_bucket.arn}"
    droplets_bucket_arn   = "${aws_s3_bucket.droplets_bucket.arn}"
    packages_bucket_arn   = "${aws_s3_bucket.packages_bucket.arn}"
    resources_bucket_arn  = "${aws_s3_bucket.resources_bucket.arn}"
    kms_key_arn           = "${aws_kms_key.blobstore_kms_key.arn}"
  }
}

resource "aws_iam_policy" "ert" {
  name   = "${var.env_name}_ert"
  policy = "${data.template_file.ert.rendered}"
}

resource "aws_iam_policy_attachment" "pas_user_policy" {
  name       = "${var.env_name}_iam_user_policy"
  users      = ["${aws_iam_user.iam_user.name}"]
  policy_arn = "${aws_iam_policy.ert.arn}"
}

resource "aws_iam_role" "pas_bucket_access" {
  name = "${var.env_name}_pas_bucket_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "pas_bucket_access" {
  name = "${var.env_name}_pas_bucket_access"
  role = "${aws_iam_role.pas_bucket_access.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": ["s3:*"],
    "Effect": "Allow",
    "Resource": [
      "${aws_s3_bucket.buildpacks_bucket.arn}",
      "${aws_s3_bucket.buildpacks_bucket.arn}/*",
      "${aws_s3_bucket.droplets_bucket.arn}",
      "${aws_s3_bucket.droplets_bucket.arn}/*",
      "${aws_s3_bucket.packages_bucket.arn}",
      "${aws_s3_bucket.packages_bucket.arn}/*",
      "${aws_s3_bucket.resources_bucket.arn}",
      "${aws_s3_bucket.resources_bucket.arn}/*"
    ]
  }]
}
EOF
}

resource "aws_iam_instance_profile" "pas_bucket_access" {
  name = "${var.env_name}_pas_bucket_access"
  role = "${aws_iam_role.pas_bucket_access.name}"
}
