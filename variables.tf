variable "env_name" {}

variable "dns_suffix" {}

variable "access_key" {}

variable "secret_key" {}

variable "region" {}

variable "availability_zones" {
  type = "list"
}

variable "create_versioned_pas_buckets" {
  default = false
}

variable "ops_manager_ami" {
  default = ""
}

variable "optional_ops_manager_ami" {
  default = ""
}

variable "ops_manager_instance_type" {
  default = "r4.large"
}

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

variable "ops_manager" {
  default = true
}

variable "optional_ops_manager" {
  default = false
}

variable "ssl_cert" {
  type        = "string"
  description = "the contents of an SSL certificate to be used by the LB, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the LB, optional if `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated LB certificate, optional if `ssl_cert` is provided"
  default     = ""
}

variable "ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated LB certificate, optional if `ssl_cert` is provided"
  default     = ""
}

variable "public_cidr" {
  type        = "string"
  description = "CIDR for the public subnets"
  default     = "10.0.0.0/22"
}

variable "pas_cidr" {
  type        = "string"
  description = "CIDR for the pas subnets"
  default     = "10.0.4.0/22"
}

variable "services_cidr" {
  type        = "string"
  description = "CIDR for the services subnets"
  default     = "10.0.8.0/22"
}

variable "rds_cidr" {
  type        = "string"
  description = "CIDR for the rds subnets"
  default     = "10.0.12.0/22"
}

variable "management_cidr" {
  type        = "string"
  description = "CIDR for the management subnets"
  default     = "10.0.16.0/26"
}

variable "isoseg_cidr" {
  type        = "string"
  description = "CIDR for the isoseg subnets"
  default     = "10.0.20.0/22"
}

/*****************************
 * Isolation Segment Options *
 *****************************/

variable "isoseg_ssl_cert" {
  type        = "string"
  description = "the contents of an SSL certificate to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_private_key" {
  type        = "string"
  description = "the contents of an SSL private key to be used by the LB, optional if `isoseg_ssl_ca_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_ca_cert" {
  type        = "string"
  description = "the contents of a CA public key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "isoseg_ssl_ca_private_key" {
  type        = "string"
  description = "the contents of a CA private key to be used to sign the generated iso seg LB certificate, optional if `isoseg_ssl_cert` is provided"
  default     = ""
}

variable "create_isoseg_resources" {
  type        = "string"
  default     = "0"
  description = "Optionally create a LB and DNS entries for a single isolation segment. Valid values are 0 or 1."
}
