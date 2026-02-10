#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

. /etc/os-release
if [ "${ID}" = "ubuntu" ]; then
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs 2>/dev/null)-prod $(lsb_release -cs 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/dotnetdev.list >/dev/null
else
  echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs 2>/dev/null | cut -d'.' -f 1)/prod $(lsb_release -cs 2>/dev/null) main" | sudo tee /etc/apt/sources.list.d/dotnetdev.list >/dev/null
fi

sudo apt-get update
sudo apt-get install -y azure-functions-core-tools-4
