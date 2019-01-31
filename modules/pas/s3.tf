resource "aws_s3_bucket" "buildpacks_bucket" {
  bucket        = "${var.env_name}-buildpacks-bucket-${var.bucket_suffix}"
  force_destroy = true

  versioning {
    enabled = "${var.create_versioned_pas_buckets}"
  }

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Buildpacks Bucket"))}"
}

resource "aws_s3_bucket" "droplets_bucket" {
  bucket        = "${var.env_name}-droplets-bucket-${var.bucket_suffix}"
  force_destroy = true

  versioning {
    enabled = "${var.create_versioned_pas_buckets}"
  }

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Droplets Bucket"))}"
}

resource "aws_s3_bucket" "packages_bucket" {
  bucket        = "${var.env_name}-packages-bucket-${var.bucket_suffix}"
  force_destroy = true

  versioning {
    enabled = "${var.create_versioned_pas_buckets}"
  }

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Packages Bucket"))}"
}

resource "aws_s3_bucket" "resources_bucket" {
  bucket        = "${var.env_name}-resources-bucket-${var.bucket_suffix}"
  force_destroy = true

  versioning {
    enabled = "${var.create_versioned_pas_buckets}"
  }

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Resources Bucket"))}"
}

# BBR Buckets

resource "aws_s3_bucket" "buildpacks_backup_bucket" {
  bucket        = "${var.env_name}-buildpacks-backup-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.create_backup_pas_buckets ? 1 : 0}"

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Buildpacks Backup Bucket"))}"
}

resource "aws_s3_bucket" "droplets_backup_bucket" {
  bucket        = "${var.env_name}-droplets-backup-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.create_backup_pas_buckets ? 1 : 0}"

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Droplets Backup Bucket"))}"
}

resource "aws_s3_bucket" "packages_backup_bucket" {
  bucket        = "${var.env_name}-packages-backup-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.create_backup_pas_buckets ? 1 : 0}"

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Packages Backup Bucket"))}"
}

resource "aws_s3_bucket" "resources_backup_bucket" {
  bucket        = "${var.env_name}-resources-backup-bucket-${var.bucket_suffix}"
  force_destroy = true

  count = "${var.create_backup_pas_buckets ? 1 : 0}"

  tags = "${merge(var.tags, map("Name", "Elastic Runtime S3 Resources Backup Bucket"))}"
}
