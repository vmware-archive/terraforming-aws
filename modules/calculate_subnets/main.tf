variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

locals {
  cidr_split= "${split("/", var.vpc_cidr)}"
  cidr_prefix = "${local.cidr_split[1]}"

  cidr_breakout_map = {
    "16" = {
      "large" = 6
      "small" = 10
      "infra_index" = 64
    }
    "20" = {
      "large" = 3
      "small" = 6
      "infra_index" = 32
    }
  }

  newbits_to_large = "${lookup(local.cidr_breakout_map[local.cidr_prefix],"large")}"
  newbits_to_small = "${lookup(local.cidr_breakout_map[local.cidr_prefix],"small")}"
  index_for_ifra_subnet = "${lookup(local.cidr_breakout_map[local.cidr_prefix],"infra_index")}"

  rds_cidr = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 3)}"
  pas_cidr      = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 1)}"
  services_cidr = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 2)}"
  pks_cidr      = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 1)}"
  pks_services_cidr = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 2)}"
  control_plane_cidr      = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 1)}"
  infrastructure_cidr = "${cidrsubnet(var.vpc_cidr, local.newbits_to_small, local.index_for_ifra_subnet)}"
  public_cidr         = "${cidrsubnet(var.vpc_cidr, local.newbits_to_large, 0)}"
}

output "public_cidr" {
  value = "${local.public_cidr}"
}
output "pas_cidr" {
  value = "${local.pas_cidr}"
}
output "services_cidr" {
  value = "${local.services_cidr}"
}
output "rds_cidr" {
  value = "${local.rds_cidr}"
}
output "infrastructure_cidr" {
  value = "${local.infrastructure_cidr}"
}
output "control_plane_cidr" {
  value = "${local.control_plane_cidr}"
}
output "pks_cidr" {
  value = "${local.pks_cidr}"
}
output "pks_services_cidr" {
  value = "${local.pks_services_cidr}"
}