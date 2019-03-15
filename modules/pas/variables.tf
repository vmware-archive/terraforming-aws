variable "env_name" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
}

variable "route_table_ids" {
  type = "list"
}

variable "internetless" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "bucket_suffix" {
  type = "string"
}

variable "zone_id" {
  type = "string"
}

variable "dns_suffix" {
  type = "string"
}

variable "use_route53" {
}

variable "create_backup_pas_buckets" {
  default = false
}

variable "create_versioned_pas_buckets" {
  default = false
}

variable "ops_manager_iam_user_name" {
  type = "string"
}

variable "iam_ops_manager_role_name" {
  type = "string"
}

variable "create_isoseg_resources" {
  default = 0
}

variable "tags" {
  type = "map"
}

module "cidr_lookup" {
  source = "../calculate_subnets"
  vpc_cidr = "${var.vpc_cidr}"
}

locals {
  pas_cidr      =  "${module.cidr_lookup.pas_cidr}"
  services_cidr =  "${module.cidr_lookup.services_cidr}"
}
