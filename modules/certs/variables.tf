variable "env_name" {
  type = "string"
}

variable "resource_name" {
  type    = "string"
  default = ""
}

variable "dns_suffix" {
  type = "string"
}

variable "subdomains" {
  type = "list"
}

variable "ssl_cert_arn" {
  type        = "string"
  description = "The ARN for the certificate to be used by the LB, optional if `ssl_cert` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_cert" {
  type        = "string"
  description = "The contents of an SSL certificate to be used by the LB, optional if `ssl_cert_arn` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_private_key" {
  type        = "string"
  description = "The contents of an SSL private key to be used by the LB, optional if `ssl_cert_arn` or `ssl_ca_cert` is provided"
  default     = ""
}

variable "ssl_ca_cert" {
  type        = "string"
  description = "The contents of a CA public key to be used to sign the generated LB certificate, optional if `ssl_cert_arn` or `ssl_cert` is provided"
  default     = ""
}

variable "ssl_ca_private_key" {
  type        = "string"
  description = "The contents of a CA private key to be used to sign the generated LB certificate, optional if `ssl_cert_arn` or `ssl_cert` is provided"
  default     = ""
}
