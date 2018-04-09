resource "aws_s3_bucket" "ops_manager_bucket" {
  bucket        = "${var.env_name}-ops-manager-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.count}"

  tags = "${merge(var.tags, var.default_tags,
    map("Name", "Ops Manager S3 Bucket")
  )}"
}
