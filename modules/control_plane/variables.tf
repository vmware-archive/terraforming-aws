variable "vpc_id" {
  type = "string"
}

variable "env_name" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {
  type = "string"
}

variable "control_cidr_bits" {
  default = 6
}

variable "control_cidr_netnum" {
  default = 1
}

variable "control_cidr_subnets_bits" {
  default = 4
}

variable "region" {
  type = "string"
}

variable "zone_id" {
  type = "string"
}

variable "dns_suffix" {
  type = "string"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "private_route_table_ids" {
  type = "list"
}

variable "tags" {
  type = "map"
}

locals {
  control_plane_cidr = "${cidrsubnet(var.vpc_cidr, var.control_cidr_bits, var.control_cidr_netnum)}"
}
