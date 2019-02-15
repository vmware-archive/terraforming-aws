#!/bin/bash

set -euox pipefail

command -v psql >/dev/null 2>&1 || { echo >&2 "I require psql but it's not installed.  Aborting."; exit 1; }

ssh_socket=/tmp/session1

function cleanup() {
  # https://unix.stackexchange.com/questions/24005/how-to-close-kill-ssh-controlmaster-connections-manually
  # https://unix.stackexchange.com/questions/83806/how-to-kill-ssh-session-that-was-started-with-the-f-option-run-in-background
  ssh -S "${ssh_socket}" -O exit "indubitably"
}

function main() {
  echo 'Creating Databases'

  local opsman_ssh_key_path=/tmp/opsman_ssh_key
  echo "${OPSMAN_PRIVATE_KEY}" > "${opsman_ssh_key_path}"
  chmod 600 "${opsman_ssh_key_path}"

  local port=5432

  trap cleanup EXIT

  ssh -fNg -M -S "${ssh_socket}" -L "${port}":"${RDS_ADDRESS}":"${RDS_PORT}" -i "${opsman_ssh_key_path}" -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no "ubuntu@${OPSMAN_URL}"

  sleep 5

  PGPASSWORD="${RDS_PASSWORD}" psql --host="127.0.0.1" --port="${port}" --username="${RDS_USERNAME}" --dbname="postgres" <<'EOF'
CREATE DATABASE atc;
CREATE DATABASE credhub;
CREATE DATABASE uaa;
EOF
}

main "$@"
