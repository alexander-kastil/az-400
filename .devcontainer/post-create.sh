#!/bin/bash

echo "Post-creation setup starting..."

# Fix permissions for the workspace directory
echo "Setting correct permissions for workspace directory..."
sudo chown -R $(whoami):$(whoami) /workspace
sudo chmod -R u+rwX /workspace

# Ensure build output directories are writable
echo "Setting permissions for .NET build output directories..."
mkdir -p /workspace/src/api/obj
mkdir -p /workspace/src/api/bin
sudo chmod -R 755 /workspace/src/api/obj
sudo chmod -R 755 /workspace/src/api/bin

# Navigate to the workspace root
cd /workspace