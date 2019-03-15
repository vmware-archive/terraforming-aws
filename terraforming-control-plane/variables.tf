variable "env_name" {}

variable "dns_suffix" {}
variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "hosted_zone" {
  default = ""
}

variable "use_route53" {
  default = true
  description = "Indicate whether or not to enable route53"
}

/**************
* Ops Manager *
***************/
variable "ops_manager_ami" {
  default = ""
}

variable "optional_ops_manager_ami" {
  default = ""
}

variable "ops_manager_instance_type" {
  default = "r4.large"
}

variable "ops_manager_private" {
  default     = false
  description = "If true, the Ops Manager will be colocated with the BOSH director on the infrastructure subnet instead of on the public subnet"
}

variable "ops_manager_vm" {
  default = true
}

variable "optional_ops_manager" {
  default = false
}

/******
* RDS *
*******/
variable "rds_db_username" {
  default = "administrator"
}

variable "rds_instance_class" {
  default = "db.m4.large"
}

variable "rds_instance_count" {
  type    = "string"
  default = 1
}

/********
* Tags  *
*********/
variable "tags" {
  type        = "map"
  default     = {}
  description = "Key/value tags to assign to all AWS resources"
}

locals {
  ops_man_subnet_id = "${var.ops_manager_private ? element(module.infra.infrastructure_subnet_ids, 0) : element(module.infra.public_subnet_ids, 0)}"

  bucket_suffix = "${random_integer.bucket.result}"

  default_tags = {
    Environment = "${var.env_name}"
    Application = "Control Plane"
  }

  actual_tags = "${merge(var.tags, local.default_tags)}"
}
