resource "aws_s3_bucket" "ops_manager_bucket" {
  bucket = "${var.env_name}-ops-manager-bucket"

  tags {
    Name = "Ops Manager S3 Bucket"
  }
}

resource "aws_s3_bucket" "buildpacks_bucket" {
  bucket = "${var.env_name}-buildpacks-bucket"

  tags {
    Name = "Elastic Runtime S3 Buildpacks Bucket"
  }
}

resource "aws_s3_bucket" "droplets_bucket" {
  bucket = "${var.env_name}-droplets-bucket"

  tags {
    Name = "Elastic Runtime S3 Droplets Bucket"
  }
}

resource "aws_s3_bucket" "packages_bucket" {
  bucket = "${var.env_name}-packages-bucket"

  tags {
    Name = "Elastic Runtime S3 Packages Bucket"
  }
}

resource "aws_s3_bucket" "resources_bucket" {
  bucket = "${var.env_name}-resources-bucket"

  tags {
    Name = "Elastic Runtime S3 Resources Bucket"
  }
}
