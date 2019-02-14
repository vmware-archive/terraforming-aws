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

data "aws_kms_alias" "blobstore_kms_key_alias" {
  name          = "alias/pas_kms_key"
}

data "aws_kms_key" "blobstore_kms_key" {
  key_id = "${data.aws_kms_alias.blobstore_kms_key_alias.target_key_id}"
}

data "aws_iam_role" "pas_bucket_access" {
  name = "pas_om_bucket_role"
}

data "aws_iam_instance_profile" "pas_bucket_access" {
    name = "pas_om_bucket_role"
}
