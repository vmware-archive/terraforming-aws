variable "env_name" {}

variable "dns_suffix" {}

variable "access_key" {}

variable "secret_key" {}

variable "region" {
  type    = "string"
  default = "us-west-1"
}

variable "availability_zones" {
  type    = "list"
  default = ["us-west-1b", "us-west-1c"]
}

variable "nat_key_pair_name" {}

variable "ops_manager_ami" {
  type    = "string"
  default = "ami-2e02454e"
}

variable "rds_db_name" {}

variable "rds_db_username" {}

variable "rds_db_password" {}

variable "rds_instance_class" {
  type    = "string"
  default = "db.m4.xlarge"
}

variable "rds_instance_count" {
  type    = "string"
  default = 1
}
