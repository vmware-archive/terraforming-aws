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

variable "region" {
  type = "string"
}

variable "zone_id" {
  type = "string"
}

variable "use_route53" {}

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

variable "lb_cert_pem" {
  type        = "string"
  description = "Certificate attached directly to LB fronting the uaa and credhub"
}

variable "lb_private_key_pem" {
  type        = "string"
  description = "Private key for lb_cert_pem, this will be loaded into ACM"
}

variable "lb_issuer" {
  type        = "string"
  description = "The intermediate certificate chain for our LB cert"
}

module "cidr_lookup" {
  source   = "../calculate_subnets"
  vpc_cidr = "${var.vpc_cidr}"
}

locals {
  control_plane_cidr = "${module.cidr_lookup.control_plane_cidr}"
}
