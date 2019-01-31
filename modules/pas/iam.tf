# Backup

data "template_file" "pas_backup_bucket_policy" {
  template = "${file("${path.module}/templates/iam_pas_backup_buckets_policy.json")}"

  vars {
    buildpacks_backup_bucket_arn = "${aws_s3_bucket.buildpacks_backup_bucket.arn}"
    droplets_backup_bucket_arn   = "${aws_s3_bucket.droplets_backup_bucket.arn}"
    packages_backup_bucket_arn   = "${aws_s3_bucket.packages_backup_bucket.arn}"
    resources_backup_bucket_arn  = "${aws_s3_bucket.resources_backup_bucket.arn}"
  }

  count = "${var.create_backup_pas_buckets ? 1 : 0}"
}

resource "aws_iam_policy" "pas_backup_bucket_policy" {
  name   = "${var.env_name}_pas_backup_bucket_policy"
  policy = "${data.template_file.pas_backup_bucket_policy.rendered}"

  count = "${var.create_backup_pas_buckets ? 1 : 0}"
}

resource "aws_iam_role_policy" "pas_backup_bucket_access" {
  name   = "${var.env_name}_pas_backup_bucket_access"
  role   = "${aws_iam_role.pas_bucket_access.id}"
  policy = "${data.template_file.pas_backup_bucket_policy.rendered}"

  count = "${var.create_backup_pas_buckets ? 1 : 0}"
}

resource "aws_iam_user_policy_attachment" "pas_backup_bucket_access" {
  user       = "${var.ops_manager_iam_user_name}"
  policy_arn = "${element(aws_iam_policy.pas_backup_bucket_policy.*.arn, 0)}"

  count = "${var.create_backup_pas_buckets ? 1 : 0}"
}

# ERT

resource "aws_iam_policy" "ert" {
  name   = "${var.env_name}_ert"
  policy = "${data.template_file.ert.rendered}"
}

resource "aws_iam_user_policy_attachment" "ert" {
  user       = "${var.ops_manager_iam_user_name}"
  policy_arn = "${aws_iam_policy.ert.arn}"
}

resource "aws_kms_key" "blobstore_kms_key" {
  description             = "${var.env_name} KMS key"
  deletion_window_in_days = 7

  tags = "${merge(var.tags, map("Name", "${var.env_name} Blobstore KMS Key"))}"
}

resource "aws_kms_alias" "blobstore_kms_key_alias" {
  name          = "alias/${var.env_name}"
  target_key_id = "${aws_kms_key.blobstore_kms_key.key_id}"
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

resource "aws_iam_instance_profile" "pas_bucket_access" {
  name = "${var.env_name}_pas_bucket_access"
  role = "${aws_iam_role.pas_bucket_access.name}"
}

resource "aws_iam_role_policy" "pas_bucket_access" {
  name = "${var.env_name}_pas_bucket_access"
  role = "${aws_iam_role.pas_bucket_access.id}"

  policy = "${data.template_file.ert.rendered}"
}

resource "aws_iam_role_policy_attachment" "pas" {
  role       = "${var.iam_ops_manager_role_name}"
  policy_arn = "${aws_iam_policy.ert.arn}"
}
