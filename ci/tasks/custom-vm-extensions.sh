#!/bin/bash -exu

main() {
  export OM_TARGET="https://$(jq -r .ops_manager_dns < "${cwd}/env-state/metadata")"

  echo "Creating Custom VM Extensions"

  om -k curl --path /api/v0/staged/vm_extensions/web-lb-security-group -x PUT -d \
    '{"name": "web-lb-security-group", "cloud_properties": { "security_groups": ["web_lb_security_group"] }}'
  om -k curl --path /api/v0/staged/vm_extensions/ssh-lb-security-group -x PUT -d \
    '{"name": "ssh-lb-security-group", "cloud_properties": { "security_groups": ["ssh_lb_security_group"] }}'
  om -k curl --path /api/v0/staged/vm_extensions/tcp-lb-security-group -x PUT -d \
    '{"name": "tcp-lb-security-group", "cloud_properties": { "security_groups": ["tcp_lb_security_group"] }}'
  om -k curl --path /api/v0/staged/vm_extensions/vms -x PUT -d \
    '{"name": "vms", "cloud_properties": { "security_groups": ["vms_security_group"] }}'
}

main "$@"
