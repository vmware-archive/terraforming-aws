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
`rds_instance_count` set to `1` but setting it to zero will skip RDS
deployment.

RDS instances take FOREVER to deploy, keep that in mind.

## Variables

- env_name: **(required)** An arbitrary unique name for namespacing resources
- access_key **(required)** Your Amazon access_key, used for deployment
- secret_key: **(require)** You Amazon secret_key, also used for deployment
- region: **(required)** Region you want to deploy your resources to
- availability_zone1: **(required)** First AZ you want to deploy to
- availability_zone2: **(required)** Second AZ you want to deploy to
- nat_key_pair_name: **(required)** Name of the key pair to add to the nat box
- ops_manager_ami: **(default: ami-2e02454e)**  Ops-manager AMI
- rds_db_name: **(default: bosh)**  Name of the RDS instance deployed
- rds_db_username: **(required)** Username for RDS authentication
- rds_db_password: **(required)** Password for RDS authentication
- rds_instance_class: **(required)** Size of the RDS to deploy
- rds_instance_count: **(default: 1)** Whether or not you would like an RDS for your deployment

## Running

### Standing up environment

```bash
terraform apply \
  -var "env_name=durian" \
  -var "access_key=access-key-id" \
  -var "secret_key=secret-access-key" \
  -var "region=us-west-1" \
  -var "availability_zone1=us-west-1a" \
  -var "availability_zone2=us-west-1b" \
  -var "nat_key_pair_name=key-pair-name" \
  -var "ops_manager_ami=ami-2e02454e" \
  -var "rds_db_name=rds-db" \
  -var "rds_db_username=rds-username" \
  -var "rds_db_password=rds-password" \
  -var "rds_instance_class=db.m3.xlarge" \
  -var "rds_instance_count=1"
```

### Tearing down environment

```bash
terraform destroy \
  -var "env_name=durian" \
  -var "access_key=access-key-id" \
  -var "secret_key=secret-access-key" \
  -var "region=us-west-1" \
  -var "availability_zone1=us-west-1a" \
  -var "availability_zone2=us-west-1b" \
  -var "nat_key_pair_name=key-pair-name" \
  -var "ops_manager_ami=ami-2e02454e" \
  -var "rds_db_name=rds-db" \
  -var "rds_db_username=rds-username" \
  -var "rds_db_password=rds-password" \
  -var "rds_instance_class=db.m3.xlarge" \
  -var "rds_instance_count=1"
```
