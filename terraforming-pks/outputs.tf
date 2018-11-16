output "iaas" {
  value = "aws"
}

output "ops_manager_bucket" {
  value = "${module.ops_manager.bucket}"
}

output "ops_manager_public_ip" {
  value = "${module.ops_manager.public_ip}"
}

output "ops_manager_dns" {
  value = "${module.ops_manager.dns}"
}

output "optional_ops_manager_dns" {
  value = "${module.ops_manager.optional_dns}"
}

output "env_dns_zone_name_servers" {
  value = "${module.infra.name_servers}"
}

output "ops_manager_iam_instance_profile_name" {
  value = "${module.ops_manager.ops_manager_iam_instance_profile_name}"
}

output "ops_manager_iam_user_name" {
  value = "${module.ops_manager.ops_manager_iam_user_name}"
}

output "ops_manager_iam_user_access_key" {
  value = "${module.ops_manager.ops_manager_iam_user_access_key}"
}

output "ops_manager_iam_user_secret_key" {
  value     = "${module.ops_manager.ops_manager_iam_user_secret_key}"
  sensitive = true
}

output "ops_manager_security_group_id" {
  value = "${module.ops_manager.security_group_id}"
}

output "vms_security_group_id" {
  value = "${module.infra.vms_security_group_id}"
}

output "public_subnet_ids" {
  value = "${module.infra.public_subnet_ids}"
}

output "public_subnets" {
  value = "${module.infra.public_subnet_ids}"
}

output "public_subnet_availability_zones" {
  value = "${module.infra.public_subnet_availability_zones}"
}

output "public_subnet_cidrs" {
  value = "${module.infra.public_subnet_cidrs}"
}

output "infrastructure_subnet_ids" {
  value = "${module.infra.infrastructure_subnet_ids}"
}

output "infrastructure_subnets" {
  value = "${module.infra.infrastructure_subnets}"
}

output "infrastructure_subnet_availability_zones" {
  value = "${module.infra.infrastructure_subnet_availability_zones}"
}

output "infrastructure_subnet_cidrs" {
  value = "${module.infra.infrastructure_subnet_cidrs}"
}

output "infrastructure_subnet_gateways" {
  value = "${module.infra.infrastructure_subnet_gateways}"
}

output "vpc_id" {
  value = "${module.infra.vpc_id}"
}

output "network_name" {
  value = "${module.infra.vpc_id}"
}

output "ops_manager_ssh_private_key" {
  sensitive = true
  value     = "${module.ops_manager.ssh_private_key}"
}

output "ops_manager_ssh_public_key_name" {
  value = "${module.ops_manager.ssh_public_key_name}"
}

output "ops_manager_ssh_public_key" {
  value = "${module.ops_manager.ssh_public_key}"
}

output "region" {
  value = "${var.region}"
}

output "azs" {
  value = "${var.availability_zones}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${module.certs.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${module.certs.ssl_private_key}"
}

output "dns_zone_id" {
  value = "${module.infra.zone_id}"
}

output "ops_manager_ip" {
  value = "${module.ops_manager.ops_manager_private_ip}"
}

output "ops_manager_private_ip" {
  value = "${module.ops_manager.ops_manager_private_ip}"
}

output "rds_address" {
  value = "${module.rds.rds_address}"
}

output "rds_port" {
  value = "${module.rds.rds_port}"
}

output "rds_username" {
  value = "${module.rds.rds_username}"
}

output "rds_password" {
  sensitive = true
  value     = "${module.rds.rds_password}"
}

# PKS ==========================================================================

output "pks_api_endpoint" {
  value = "${module.pks.domain}"
}

output "pks_subnet_ids" {
  value = "${module.pks.pks_subnet_ids}"
}

output "pks_subnets" {
  value = "${module.pks.pks_subnet_ids}"
}

output "pks_subnet_availability_zones" {
  value = "${module.pks.pks_subnet_availability_zones}"
}

output "pks_subnet_cidrs" {
  value = "${module.pks.pks_subnet_cidrs}"
}

output "pks_subnet_gateways" {
  value = "${module.pks.pks_subnet_gateways}"
}

output "pks_master_iam_instance_profile_name" {
  value = "${module.pks.pks_master_iam_instance_profile_name}"
}

output "pks_worker_iam_instance_profile_name" {
  value = "${module.pks.pks_worker_iam_instance_profile_name}"
}

output "pks_master_security_group_id" {
  value = "${module.pks.pks_master_security_group_id}"
}

output "pks_api_target_groups" {
  value = "${module.pks.pks_api_target_groups}"
}

# PKS Services =================================================================

output "services_subnet_ids" {
  value = "${module.pks.services_subnet_ids}"
}

output "services_subnets" {
  value = "${module.pks.services_subnet_ids}"
}

output "services_subnet_availability_zones" {
  value = "${module.pks.services_subnet_availability_zones}"
}

output "services_subnet_cidrs" {
  value = "${module.pks.services_subnet_cidrs}"
}

output "services_subnet_gateways" {
  value = "${module.pks.services_subnet_gateways}"
}
