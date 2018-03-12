resource "aws_s3_bucket" "ops_manager_bucket" {
  bucket        = "${var.env_name}-ops-manager-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.count}"

  tags {
    Name = "Ops Manager S3 Bucket"
  }
}
