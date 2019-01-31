terraform {
  # Version of Terraform to include in the bundle. An exact version number
  # is required.
  version = "0.11.11"
}

# Define which provider plugins are to be included
providers {

  # Pin to a version that works on C2S
  aws = ["1.50.0"]

  tls = ["~> 1.2.0"]

  random = ["~> 1.3.1"]

  template = ["~> 1.0.0"]

}