#!/usr/bin/env bash

# Fix CRLF issues when run from Windows-mounted filesystems (WSL/Docker contexts)
sed -i 's/\r$//' "$0" || true

# Add Microsoft package repository for Ubuntu 24.04 (ubuntu-latest)
wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt-get update
apt-get install -y apt-transport-https
apt-get update
# Install only .NET 10 SDK
apt-get install -y dotnet-sdk-10.0
