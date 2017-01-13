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
  default = "ami-2e02454e"
}

variable "optional_ops_manager_ami" {
  type    = "string"
  default = ""
}

variable "rds_db_name" {}

variable "rds_db_username" {}

variable "rds_db_password" {}

variable "rds_instance_class" {
  type = "string"
}

variable "rds_instance_count" {
  type    = "string"
  default = 1
}
