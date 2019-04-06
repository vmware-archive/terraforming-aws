variable "region" {
  type = "string"
}

variable "private" {}

variable "env_name" {}

variable "ami" {}

variable "optional_ami" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "vpc_id" {}

variable "vpc_cidr" {}

variable "iam_users" {
  default = 1
}

variable "additional_iam_roles_arn" {
  type    = "list"
  default = []
}

variable "dns_suffix" {}

variable "use_route53" {}

variable "zone_id" {}

variable "bucket_suffix" {}

variable "tags" {
  type = "map"
}

locals {
  ops_man_vm          = "${var.ami == "" ? 0 : 1}"
  optional_ops_man_vm = "${var.optional_ami == "" ? 0 : 1}"
}
