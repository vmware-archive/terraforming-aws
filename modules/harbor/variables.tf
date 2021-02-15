variable "env_name" {
  type = "string"
}

variable "vpc_id" {
  type = "string"
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

variable "use_route53" {
}

variable "tags" {
  type = "map"
}
