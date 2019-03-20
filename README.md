# Terraforming AWS [![build-status](https://infra.ci.cf-app.com/api/v1/teams/main/pipelines/terraforming-aws/jobs/deploy-pas/badge)](https://infra.ci.cf-app.com/teams/main/pipelines/terraforming-aws)

## What is this?

Set of terraform modules for deploying Ops Manager, PAS and PKS infrastructure requirements like:

- Friendly DNS entries in Route53
- A RDS instance (optional)
- A Virtual Private Network (VPC), subnets, Security Groups
- Necessary s3 buckets
- NAT Gateway services
- Network Load Balancers
- An IAM User with proper permissions
- Tagged resources

Note: This is not an exhaustive list of resources created, this will vary depending of your arguments and what you're deploying.

## Prerequisites

### Terraform CLI

```bash
brew update
brew install terraform
```

### AWS Permissions
- AmazonEC2FullAccess
- AmazonRDSFullAccess
- AmazonRoute53FullAccess
- AmazonS3FullAccess
- AmazonVPCFullAccess
- IAMFullAccess
- AWSKeyManagementServicePowerUser

Note: You will also need to create a custom policy as the following and add to
      the same user:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "KMSKeyDeletionAndUpdate",
            "Effect": "Allow",
            "Action": [
                "kms:UpdateKeyDescription",
                "kms:ScheduleKeyDeletion"
            ],
            "Resource": "*"
        }
    ]
}
```

## Deploying Infrastructure

First, you'll need to clone this repo. Then, depending on if you're deploying PAS or PKS you need to perform the following steps:

1. `cd` into the proper directory:
    - [terraforming-pas/](terraforming-pas/)
    - [terraforming-pks/](terraforming-pks/)
    - [terraforming-control-plane/](terraforming-control-plane/)
1. Create [`terraform.tfvars`](/README.md#var-file) file
1. Populate [credentials](/README.md#credentials) file or env variables
1. Run terraform apply:
  ```bash
  terraform init
  terraform plan -out=pcf.tfplan
  terraform apply pcf.tfplan
  ```

### Var File

Copy the stub content below into a file called `terraform.tfvars` and put it in the root of this project.
These vars will be used when you run `terraform apply`.
You should fill in the stub values with the correct content.

```hcl
env_name           = "some-environment-name"
region             = "us-west-1"
availability_zones = ["us-west-1a", "us-west-1c"]
ops_manager_ami    = "ami-4f291f2f"
rds_instance_count = 1
dns_suffix         = "example.com"
vpc_cidr           = "10.0.0.0/16"
use_route53        = true
use_ssh_routes     = true
use_tcp_routes     = true

ssl_cert = <<EOF
-----BEGIN CERTIFICATE-----
some cert
-----END CERTIFICATE-----
EOF

ssl_private_key = <<EOF
-----BEGIN RSA PRIVATE KEY-----
some cert private key
-----END RSA PRIVATE KEY-----
EOF

tags = {
    Team = "Dev"
    Project = "WebApp3"
}
```

### Credentials

Create a `credentials.yml` file with the following contents:

```
provider "aws" {
  access_key = "YOUR_AWS_ACCESS_KEY"
  secret_key = "YOUR_AWS_SECRET_KEY"
  region     = "YOUR_AWS_REGION"
}
```

Alternatively, populate the following environment variables before running the `terraform plan`:

```
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_DEFAULT_REGION="us-west-2"
```

See Terraform documentation on the [AWS Provider](https://www.terraform.io/docs/providers/aws/) for more ways on providing credentials, especially if using [EC2 Roles](https://www.terraform.io/docs/providers/aws/#ec2-role) or [`AWS_SESSION_TOKEN`](https://www.terraform.io/docs/providers/aws/#environment-variables).

### Variables

- env_name: **(required)** An arbitrary unique name for namespacing resources
- region: **(required)** Region you want to deploy your resources to
- availability_zones: **(required)** List of AZs you want to deploy to
- dns_suffix: **(required)** Domain to add environment subdomain to
- hosted_zone: **(optional)** Parent domain *already* managed by Route53. If specified, the DNS records will be added to this Route53 zone instead of a new zone.
- ssl_cert: **(optional)** SSL certificate for HTTP load balancer configuration. Required unless `ssl_ca_cert` is specified.
- ssl_private_key: **(optional)** Private key for above SSL certificate. Required unless `ssl_ca_cert` is specified.
- ssl_ca_cert: **(optional)** SSL CA certificate used to generate self-signed HTTP load balancer certificate. Required unless `ssl_cert` is specified.
- ssl_ca_private_key: **(optional)** Private key for above SSL CA certificate. Required unless `ssl_cert` is specified.
- tags: **(optional)** A map of AWS tags that are applied to the created resources. By default, the following tags are set: Application = Cloud Foundry, Environment = $env_name
- vpc_cidr: **(default: 10.0.0.0/16)** Internal CIDR block for the AWS VPC.
- use_route53: **(default: true)** Controls whether or not Route53 DNS resources are created.
- use_ssh_routes: **(default: true)** Enable ssh routing
- use_tcp_routes: **(default: true)** Controls whether or not tcp routing is enabled.

### Ops Manager (optional)
- ops_manager_ami: **(optional)**  Ops Manager AMI, get the right AMI according to your region from the AWS guide downloaded from [Pivotal Network](https://network.pivotal.io/products/ops-manager) (if set to `""` no Ops Manager VM will be created)
- optional_ops_manager_ami: **(optional)**  Additional Ops Manager AMI, get the right AMI according to your region from the AWS guide downloaded from [Pivotal Network](https://network.pivotal.io/products/ops-manager)
- ops_manager_instance_type: **(default: m4.large)** Ops Manager instance type
- ops_manager_private: **(default: false)** Set to true if you want Ops Manager deployed in a private subnet instead of a public subnet

### S3 Buckets (optional) (PAS only)
- create_backup_pas_buckets: **(default: false)**
- create_versioned_pas_buckets: **(default: false)**

### RDS (optional)
- rds_instance_count: **(default: 0)** Whether or not you would like an RDS for your deployment
- rds_instance_class: **(default: db.m4.large)** Size of the RDS to deploy
- rds_db_username: **(default: admin)** Username for RDS authentication

### Isolation Segments (optional)  (PAS only)
- create_isoseg_resources **(optional)** Set to 1 to create HTTP load-balancer across 3 zones for isolation segments.
- isoseg_ssl_cert: **(optional)** SSL certificate for Iso Seg HTTP load balancer configuration. Required unless `isoseg_ssl_ca_cert` is specified.
- isoseg_ssl_private_key: **(optional)** Private key for above SSL certificate. Required unless `isoseg_ssl_ca_cert` is specified.
- isoseg_ssl_ca_cert: **(optional)** SSL CA certificate used to generate self-signed Iso Seg HTTP load balancer certificate. Required unless `isoseg_ssl_cert` is specified.
- isoseg_ssl_ca_private_key: **(optional)** Private key for above SSL CA certificate. Required unless `isoseg_ssl_cert` is specified.

## Notes

You can choose whether you would like an RDS or not. By default we have
`rds_instance_count` set to `0` but setting it to `1` will deploy an RDS instance.

Note: RDS instances take a long time to deploy, keep that in mind. They're not required.

## Tearing down environment

**Note:** This will only destroy resources deployed by Terraform. You will need to clean up anything deployed on top of that infrastructure yourself (e.g. by running `om delete-installation`)

```bash
terraform destroy
```

## Looking to setup a different IaaS

We have have other terraform templates:

- [Azure](https://github.com/pivotal-cf/terraforming-azure)
- [Google Cloud Platform](https://github.com/pivotal-cf/terraforming-gcp)
- [vSphere](https://github.com/pivotal-cf/terraforming-vsphere)
- [OpenStack](https://github.com/pivotal-cf/terraforming-openstack)
