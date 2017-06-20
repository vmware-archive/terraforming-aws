# How Does One Use This?

## What Does This Do?

A booted ops-manager plus a whole BOATLOAD of other goodies, including:

- Friendly DNS entries brought to you by Route53
- An RDS
- A VPC, with security groups
- A whole mess of s3 buckets (5 in total - for all your storage needs)
- An amazing NAT Box
- SSH/HTTPS/TCP ELBs
- An IAM User

## Looking to setup a different IAAS

We have have other terraform templates to help you!

- [azure](https://github.com/pivotal-cf/terraforming-azure)
- [gcp](https://github.com/pivotal-cf/terraforming-gcp)

This list will be updated when more infrastructures come along.

## Prerequisites

```bash
go get -u github.com/hashicorp/terraform
```

## Notes

You can choose whether you would like an RDS or not. By default we have
`rds_instance_count` set to `0` but setting it to 1 will deploy an RDS.

RDS instances take FOREVER to deploy, keep that in mind.

## Variables

- env_name: **(required)** An arbitrary unique name for namespacing resources
- access_key **(required)** Your Amazon access_key, used for deployment
- secret_key: **(required)** Your Amazon secret_key, also used for deployment
- region: **(required)** Region you want to deploy your resources to
- availability_zones: **(required)** List of AZs you want to deploy to
- ops_manager_ami: **(required)**  Ops Manager AMI
- ops_manager_instance_type: **(default: m4.large)** Ops Manager instance type
- rds_db_username: **(default: admin)** Username for RDS authentication
- rds_instance_class: **(default: db.m4.large)** Size of the RDS to deploy
- rds_instance_count: **(default: 0)** Whether or not you would like an RDS for your deployment
- dns_suffix: **(required)** Domain to add environment subdomain to

## Isolation Segments (optional)
- create_isoseg_resources *(optional)* Set to 1 to create HTTP load-balancer across 3 zones for isolation segments. If set, the following 2 isoseg variables are also required.
- isoseg_ssl_cert: *(optional)* SSL certificate for HTTP load balancer configuration. Can be either trusted or self-signed.
- isoseg_ssl_cert_private_key:  *(optional)* Private key for above SSL certificate.

## Running

### Standing up environment

```bash
terraform apply \
  -var "env_name=durian" \
  -var "access_key=access-key-id" \
  -var "secret_key=secret-access-key" \
  -var "region=us-west-1" \
  -var "availability_zones=[\"us-west-1a\", \"us-west-1b\"] \
  -var "ops_manager_ami=ami-2e02454e" \
  -var "rds_instance_count=1" \
  -var "dns_suffix=myparentzone.cool.com"
```

### Tearing down environment

```bash
terraform destroy \
  -var "env_name=durian" \
  -var "access_key=access-key-id" \
  -var "secret_key=secret-access-key" \
  -var "region=us-west-1" \
  -var "availability_zones=[\"us-west-1a\", \"us-west-1b\"] \
  -var "ops_manager_ami=ami-2e02454e" \
  -var "rds_instance_count=1" \
  -var "dns_suffix=myparentzone.cool.com"
```
