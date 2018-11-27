variable "env_name" {}

variable "dns_suffix" {}

variable "hosted_zone" {
  default = ""
}

variable "access_key" {}

variable "secret_key" {}

variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

/****************
* Ops Manager *
*****************/

variable "ops_manager_ami" {
  default = ""
}

variable "optional_ops_manager_ami" {
  default = ""
}

variable "ops_manager_instance_type" {
  default = "r4.large"
}

variable "ops_manager_private" {
  default     = false
  description = "If true, the Ops Manager will be colocated with the BOSH director on the infrastructure subnet instead of on the public subnet"
}

variable "ops_manager_vm" {
  default = true
}

variable "optional_ops_manager" {
  default = false
}

/*******************
* SSL Certificates *
********************/

variable "ssl_cert" {
  type        = "string"
  description = "the contents of an SSL certificate to be used by the PKS API, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the PKS API, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated PKS API certificate, optional if `ssl_cert` is provided"
  default     = ""
}

variable "ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated PKS API certificate, optional if `ssl_cert` is provided"
  default     = ""
}

/******
* RDS *
*******/

variable "rds_db_username" {
  default = "admin"
}

variable "rds_instance_class" {
  default = "db.m4.large"
}

variable "rds_instance_count" {
  type    = "string"
  default = 0
}

/*******
* Tags *
********/

variable "tags" {
  type        = "map"
  default     = {}
  description = "Key/value tags to assign to all AWS resources"
}
