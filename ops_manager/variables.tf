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

variable "additional_iam_role_arn" {
  type = "string"
}

variable "dns_suffix" {}

variable "zone_id" {}

variable "bucket_suffix" {}

variable "tags" {
  type = "map"
}
