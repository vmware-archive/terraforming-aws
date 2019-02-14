data "aws_iam_role" "ops_manager" {
  name = "DIRECTOR"
}

data "aws_iam_instance_profile" "ops_manager" {
  name = "DIRECTOR"
}
