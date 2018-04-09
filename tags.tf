locals {
  default_tags = {
    Environment = "${var.env_name}"
    Application = "Cloud Foundry"
  }
}
