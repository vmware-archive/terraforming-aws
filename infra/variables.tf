variable "env_name" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "hosted_zone" {
  type = "string"
  default = ""
}

variable "dns_suffix" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Key/value tags to assign to all AWS resources"
}

variable "nat_ami_map" {
  type = "map"

  default = {
    us-east-1      = "ami-303b1458"
    us-east-2      = "ami-4e8fa32b"
    us-west-1      = "ami-7da94839"
    us-west-2      = "ami-69ae8259"
    eu-west-1      = "ami-6975eb1e"
    eu-central-1   = "ami-46073a5b"
    ap-southeast-1 = "ami-b49dace6"
    ap-southeast-2 = "ami-e7ee9edd"
    ap-northeast-1 = "ami-03cf3903"
    ap-northeast-2 = "ami-8e0fa6e0"
    sa-east-1      = "ami-fbfa41e6"
  }
}

locals {
  infrastructure_cidr = "${cidrsubnet(var.vpc_cidr, 10, 64)}"
  public_cidr         = "${cidrsubnet(var.vpc_cidr, 6, 0)}"
}
