provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"

  version = "~> 1.60"
}

terraform {
  required_version = "< 0.12.0"
}

provider "random" {
  version = "~> 2.0"
}

provider "template" {
  version = "~> 1.0"
}

provider "tls" {
  version = "~> 1.2"
}

resource "random_integer" "bucket" {
  min = 1
  max = 100000
}

module "infra" {
  source = "../modules/infra"

  region             = "${var.region}"
  env_name           = "${var.env_name}"
  availability_zones = "${var.availability_zones}"
  vpc_cidr           = "${var.vpc_cidr}"

  hosted_zone = "${var.hosted_zone}"
  dns_suffix  = "${var.dns_suffix}"
  use_route53 = "${var.use_route53}"

  internetless = false
  tags         = "${local.actual_tags}"
}

module "add_ns_to_hosted_zone" {
  source            = "../modules/add_ns_to_hosted_zone"
  top_level_zone_id = "${var.top_level_zone_id}"
  zone_name         = "${var.env_name}.${var.dns_suffix}"
  name_servers      = "${module.infra.name_servers}"
}

module "ops_manager" {
  source = "../modules/ops_manager"

  subnet_id = "${local.ops_man_subnet_id}"

  env_name      = "${var.env_name}"
  region        = "${var.region}"
  ami           = "${var.ops_manager_ami}"
  optional_ami  = "${var.optional_ops_manager_ami}"
  instance_type = "${var.ops_manager_instance_type}"
  private       = "${var.ops_manager_private}"
  vpc_id        = "${module.infra.vpc_id}"
  vpc_cidr      = "${var.vpc_cidr}"
  dns_suffix    = "${var.dns_suffix}"
  zone_id       = "${module.infra.zone_id}"
  use_route53   = "${var.use_route53}"

  bucket_suffix = "${local.bucket_suffix}"

  tags = "${local.actual_tags}"
}

module "control_plane" {
  source                  = "../modules/control_plane"
  vpc_id                  = "${module.infra.vpc_id}"
  env_name                = "${var.env_name}"
  availability_zones      = "${var.availability_zones}"
  vpc_cidr                = "${var.vpc_cidr}"
  public_subnet_ids       = "${module.infra.public_subnet_ids}"
  private_route_table_ids = "${module.infra.deployment_route_table_ids}"
  tags                    = "${local.actual_tags}"
  region                  = "${var.region}"
  dns_suffix              = "${var.dns_suffix}"
  zone_id                 = "${module.infra.zone_id}"
  use_route53             = "${var.use_route53}"

  lb_cert_pem        = "${var.tls_wildcard_certificate}"
  lb_issuer          = "${var.tls_ca_certificate}"
  lb_private_key_pem = "${var.tls_private_key}"
}

module "rds" {
  source = "../modules/rds"

  rds_db_username    = "${var.rds_db_username}"
  rds_instance_class = "${var.rds_instance_class}"
  rds_instance_count = "${var.rds_instance_count}"

  engine         = "postgres"
  engine_version = "9.6.10"
  db_port        = 5432

  env_name           = "${var.env_name}"
  availability_zones = "${var.availability_zones}"
  vpc_cidr           = "${var.vpc_cidr}"
  vpc_id             = "${module.infra.vpc_id}"

  tags = "${local.actual_tags}"
}

resource "null_resource" "create_databases" {
  count = "${var.rds_instance_count == 1 ? 1 : 0}"

  provisioner "local-exec" {
    command     = "./db/create_databases.sh"
    interpreter = ["bash", "-c"]

    environment {
      OPSMAN_URL         = "${module.ops_manager.public_ip}"
      OPSMAN_PRIVATE_KEY = "${module.ops_manager.ssh_private_key}"

      RDS_DB_NAME  = "${module.rds.rds_db_name}"
      RDS_PORT     = "${module.rds.rds_port}"
      RDS_ADDRESS  = "${module.rds.rds_address}"
      RDS_USERNAME = "${module.rds.rds_username}"
      RDS_PASSWORD = "${module.rds.rds_password}"
    }
  }
}
