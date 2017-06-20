variable "env_name" {}

variable "dns_suffix" {}

variable "access_key" {}

variable "secret_key" {}

variable "region" {
  type = "string"
}

variable "availability_zones" {
  type = "list"
}

variable "ops_manager_ami" {
  type    = "string"
  default = ""
}

variable "optional_ops_manager_ami" {
  type    = "string"
  default = ""
}

variable "rds_db_username" {
  type    = "string"
  default = "admin"
}

variable "rds_instance_class" {
  type    = "string"
  default = "db.m3.large"
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

/*****************************
 * Isolation Segment Options *
 *****************************/

variable "isoseg_ssl_cert" {
  type        = "string"
  description = "ssl certificate content"
  default     = ""
}

variable "isoseg_ssl_cert_private_key" {
  type        = "string"
  description = "ssl certificate private key content"
  default     = ""
}

variable "create_isoseg_resources" {
  type        = "string"
  default     = "0"
  description = "Optionally create a LB and DNS entries for a single isolation segment. Valid values are 0 or 1."
}
