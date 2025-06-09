#!/bin/sh
set -eu

source_url="https://apt.releases.hashicorp.com"
keyring_path="/usr/share/keyrings/hashicorp-archive-keyring.gpg"
source_path="/etc/apt/sources.list.d/hashicorp.list"

# Install keyring
wget -O - "${source_url}/gpg" | sudo gpg --dearmor -o "${keyring_path}"

# Add repository source
echo "deb [arch=$(dpkg --print-architecture) signed-by=${keyring_path}]" \
  "${source_url} $(lsb_release -cs) main" | sudo tee "${source_path}"

# Update with repository
sudo apt update
