variable "count" {}

variable "optional_count" {}

variable "private" {}

variable "env_name" {}

variable "ami" {}

variable "optional_ami" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "vpc_id" {}

variable "vpc_cidr" {}

variable "iam_ops_manager_user_name" {}

variable "iam_ops_manager_role_name" {}

variable "iam_ops_manager_role_arn" {}

variable "iam_pas_bucket_role_arn" {}

variable "instance_profile_name" {}

variable "instance_profile_arn" {}

variable "dns_suffix" {}

variable "zone_id" {}

variable "bucket_suffix" {}

variable "tags" {
  type = "map"
}

variable "default_tags" {
  type = "map"
}
