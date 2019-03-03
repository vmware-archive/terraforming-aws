variable "rds_db_username" {
  default = "admin"
}

variable "rds_instance_class" {
  default = "db.m4.large"
}

variable "engine" {
  type = "string"
}

variable "engine_version" {
  type = "string"
}

variable "db_port" {}

variable "rds_instance_count" {
  type    = "string"
  default = 0
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

variable "vpc_id" {
  type = "string"
}

variable "rds_cidr_bits" {
  default = 6
}

variable "rds_cidr_netnum" {
  default = 3
}

variable "rds_cidr_subnets_bits" {
  default = 2
}

variable "tags" {
  type = "map"
}

locals {
  rds_cidr = "${cidrsubnet(var.vpc_cidr, var.rds_cidr_bits, var.rds_cidr_netnum)}"
}
