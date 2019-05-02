resource "aws_iam_server_certificate" "lb_managed_cert" {
  name              = "${var.env_name}_lb_managed_cert"
  certificate_body  = "${var.lb_cert_pem}"
  private_key       = "${var.lb_private_key_pem}"
  certificate_chain = "${var.lb_issuer}"
}
