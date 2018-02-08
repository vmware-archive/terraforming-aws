#!/bin/bash

set -e

# SET THIS ENVIRONMENT DOMAIN
ENVIRONMENT_DOMAIN=customer.digs.cf

# You could customize APPS and SYSTEM domains if you would like.
APPS_DOMAIN=apps.${ENVIRONMENT_DOMAIN}
SYSTEM_DOMAIN=sys.${ENVIRONMENT_DOMAIN}

local_openssl_config="
[ req ]
prompt = no
distinguished_name = req_distinguished_name
x509_extensions = san_self_signed
[ req_distinguished_name ]
CN=*.${APPS_DOMAIN}
[ san_self_signed ]
subjectAltName = DNS:*.${APPS_DOMAIN}, DNS:*.${SYSTEM_DOMAIN}, DNS:*.uaa.${SYSTEM_DOMAIN}, DNS:*.login.${SYSTEM_DOMAIN}
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = CA:true
keyUsage = nonRepudiation, digitalSignature, keyEncipherment, dataEncipherment, keyCertSign, cRLSign
extendedKeyUsage = serverAuth, clientAuth, timeStamping
"

openssl req \
  -newkey rsa:2048 -nodes \
  -keyout "${APPS_DOMAIN}.key.pem" \
  -x509 -sha256 -days 3650 \
  -config <(echo "$local_openssl_config") \
  -out "${APPS_DOMAIN}.cert.pem"

openssl x509 -noout -text -in "${APPS_DOMAIN}.cert.pem"
