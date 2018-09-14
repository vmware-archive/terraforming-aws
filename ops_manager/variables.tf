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

variable "iam_pas_bucket_role_arn" {}

variable "dns_suffix" {}

variable "zone_id" {}

variable "bucket_suffix" {}

variable "tags" {
  type = "map"
}
