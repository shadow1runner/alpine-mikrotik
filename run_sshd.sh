#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Prepare run dirs
if [ ! -d "/var/run/sshd" ]; then
  mkdir -p /var/run/sshd
fi

# Set root password
echo "root:${SSH_PASSWORD}" | chpasswd

# Start SSH
echo "starting sshd, this will block, feel free to use ssh for connections"
/usr/sbin/sshd -D
