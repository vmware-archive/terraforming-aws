terraform {
  # Version of Terraform to include in the bundle. An exact version number
  # is required.
  version = "0.11.10"
}

# Define which provider plugins are to be included
providers {
  # Include the newest "aws" provider version in the 1.0 series.
  aws = ["~> 1.0"]

  tls = ["~> 1.0"]

  random = ["~> 1.0"]

  template = ["~> 1.0"]

  tls = ["~> 1.0"]
}