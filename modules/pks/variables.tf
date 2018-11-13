variable "env_name" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_id" {
  type = "string"
}

variable "vpc_cidr" {
  type = "string"
}

variable "private_route_table_ids" {
  type = "list"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "zone_id" {
  type = "string"
}

variable "dns_suffix" {
  type = "string"
}

variable "tags" {
  type = "map"
}

locals {
  pks_cidr          = "${cidrsubnet(var.vpc_cidr, 6, 1)}"
  pks_services_cidr = "${cidrsubnet(var.vpc_cidr, 6, 2)}"
}
