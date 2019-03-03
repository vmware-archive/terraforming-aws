variable "env_name" {
  type = "string"
}

variable "region" {
  type = "string"
}

variable "hosted_zone" {
  type    = "string"
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

variable "infra_cidr_bits" {
  default = 10
}

variable "infra_cidr_netnum" {
  default = 64
}

variable "infra_cidr_subnets_bits" {
  default = 2
}

variable "public_cidr_bits" {
  default = 6
}

variable "public_cidr_netnum" {
  default = 0
}

variable "public_cidr_subnets_bits" {
  default = 2
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Key/value tags to assign to all AWS resources"
}

variable "internetless" {}

variable "nat_ami_map" {
  type = "map"

  default = {
    ap-northeast-1 = "ami-0cf78ae724f63bac0"
    ap-northeast-2 = "ami-08cfa02141f9e9bee"
    ap-south-1     = "ami-0aba92643213491b9"
    ap-southeast-1 = "ami-0cf24653bcf894797"
    ap-southeast-2 = "ami-00c1445796bc0a29f"
    ca-central-1   = "ami-b61b96d2"
    eu-central-1   = "ami-06465d49ba60cf770"
    eu-west-1      = "ami-0ea87e2bfa81ca08a"
    eu-west-2      = "ami-e6768381"
    eu-west-3      = "ami-0050bb60cea70c5b3"
    sa-east-1      = "ami-09c013530239687aa"
    us-east-1      = "ami-0422d936d535c63b1"
    us-east-2      = "ami-0f9c61b5a562a16af"
    us-gov-west-1  = "ami-c177eba0"
    us-west-1      = "ami-0d4027d2cdbca669d"
    us-west-2      = "ami-40d1f038"
  }
}

locals {
  infrastructure_cidr = "${cidrsubnet(var.vpc_cidr, var.infra_cidr_bits, var.infra_cidr_netnum)}"
  public_cidr         = "${cidrsubnet(var.vpc_cidr, var.public_cidr_bits, var.public_cidr_netnum)}"
}
