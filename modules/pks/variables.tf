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

variable "pks_cidr_bits" {
  default = 6
}

variable "pks_cidr_netnum" {
  default = 1
}

variable "pks_cidr_subnets_bits" {
  default = 2
}

variable "pks_services_cidr_bits" {
  default = 6
}

variable "pks_services_cidr_netnum" {
  default = 2
}

variable "pks_services_cidr_subnet_bits" {
  default = 2
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
  pks_cidr          = "${cidrsubnet(var.vpc_cidr, var.pks_cidr_bits, var.pks_cidr_netnum)}"
  pks_services_cidr = "${cidrsubnet(var.vpc_cidr, var.pks_services_cidr_bits, var.pks_services_cidr_netnum)}"
}
