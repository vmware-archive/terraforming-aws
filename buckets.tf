resource "aws_s3_bucket" "top_level" {
  bucket = "${var.env_name}"

  tags {
    Name = "terraform auto-generated s3 bucket"
  }
}
