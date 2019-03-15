output "iaas" {
  value = "aws"
}

output "ops_manager_bucket" {
  value = "${module.ops_manager.bucket}"
}

output "pas_buildpacks_bucket" {
  value = "${module.pas.pas_buildpacks_bucket}"
}

output "pas_droplets_bucket" {
  value = "${module.pas.pas_droplets_bucket}"
}

output "pas_packages_bucket" {
  value = "${module.pas.pas_packages_bucket}"
}

output "pas_resources_bucket" {
  value = "${module.pas.pas_resources_bucket}"
}

output "pas_buildpacks_backup_bucket" {
  value = "${module.pas.pas_buildpacks_backup_bucket}"
}

output "pas_droplets_backup_bucket" {
  value = "${module.pas.pas_droplets_backup_bucket}"
}

output "pas_packages_backup_bucket" {
  value = "${module.pas.pas_packages_backup_bucket}"
}

output "pas_resources_backup_bucket" {
  value = "${module.pas.pas_resources_backup_bucket}"
}

output "blobstore_kms_key_id" {
  value = "${module.pas.blobstore_kms_key_id}"
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

output "optional_ops_manager_public_ip" {
  value = "${module.ops_manager.optional_public_ip}"
}

output "env_dns_zone_name_servers" {
  value = "${module.infra.name_servers}"
}

output "sys_domain" {
  value = "sys.${var.env_name}.${var.dns_suffix}"
}

output "apps_domain" {
  value = "apps.${var.env_name}.${var.dns_suffix}"
}

output "tcp_domain" {
  value = "tcp.${var.env_name}.${var.dns_suffix}"
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

output "pas_bucket_iam_instance_profile_name" {
  value = "${module.pas.pas_bucket_iam_instance_profile_name}"
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

output "aws_lb_interface_endpoint_ips" {
  value = "${module.infra.aws_lb_interface_endpoint_ips}"
}

output "aws_ec2_interface_endpoint_ips" {
  value = "${module.infra.aws_ec2_interface_endpoint_ips}"
}

output "infrastructure_subnet_gateways" {
  value = "${module.infra.infrastructure_subnet_gateways}"
}

output "pas_subnet_ids" {
  value = "${module.pas.pas_subnet_ids}"
}

output "pas_subnets" {
  value = "${module.pas.pas_subnet_ids}"
}

output "pas_subnet_availability_zones" {
  value = "${module.pas.pas_subnet_availability_zones}"
}

output "pas_subnet_cidrs" {
  value = "${module.pas.pas_subnet_cidrs}"
}

output "pas_subnet_gateways" {
  value = "${module.pas.pas_subnet_gateways}"
}

output "services_subnet_ids" {
  value = "${module.pas.services_subnet_ids}"
}

output "services_subnets" {
  value = "${module.pas.services_subnet_ids}"
}

output "services_subnet_availability_zones" {
  value = "${module.pas.services_subnet_availability_zones}"
}

output "services_subnet_cidrs" {
  value = "${module.pas.services_subnet_cidrs}"
}

output "services_subnet_gateways" {
  value = "${module.pas.services_subnet_gateways}"
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

output "web_target_groups" {
  value = "${module.pas.web_target_groups}"
}

output "tcp_target_groups" {
  value = "${module.pas.tcp_target_groups}"
}

output "ssh_target_groups" {
  value = "${module.pas.ssh_target_groups}"
}

output "ssl_cert" {
  sensitive = true
  value     = "${module.pas_certs.ssl_cert}"
}

output "ssl_private_key" {
  sensitive = true
  value     = "${module.pas_certs.ssl_private_key}"
}

output "isoseg_target_groups" {
  value = ["${module.pas.isoseg_target_groups}"]
}

output "isoseg_ssl_cert" {
  sensitive = true
  value     = "${module.isoseg_certs.ssl_cert}"
}

output "isoseg_ssl_private_key" {
  sensitive = true
  value     = "${module.isoseg_certs.ssl_private_key}"
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

/*****************************
 * Deprecated *
 *****************************/

output "management_subnet_ids" {
  value = "${module.infra.infrastructure_subnet_ids}"
}

output "management_subnets" {
  value = "${module.infra.infrastructure_subnets}"
}

output "management_subnet_availability_zones" {
  value = "${module.infra.infrastructure_subnet_availability_zones}"
}

output "management_subnet_cidrs" {
  value = "${module.infra.infrastructure_subnet_cidrs}"
}

output "management_subnet_gateways" {
  value = "${module.infra.infrastructure_subnet_gateways}"
}
