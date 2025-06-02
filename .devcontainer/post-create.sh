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

# Verify Azure tools installation
echo "Verifying Azure tools installation..."

echo "✓ Python version:"
python3 --version

echo "✓ Azure CLI version:"
az --version | head -1

echo "✓ Azure Developer CLI version:"
azd version

echo "✓ Azure Functions Core Tools version:"
func --version

echo "✓ Node.js version:"
node --version

echo "✓ .NET version:"
dotnet --version

echo "✓ Angular CLI version:"
ng version --skip-git || echo "Angular CLI installed"

echo ""
echo "🎉 Development environment setup complete!"
echo ""
echo "Available tools:"
echo "  - Python 3.11 for Azure Functions development"
echo "  - Azure CLI for Azure resource management"
echo "  - Azure Developer CLI (azd) for Azure development workflows"
echo "  - Azure Functions Core Tools for local function development"
echo "  - Node.js 20.12.2 & Angular CLI 19 for frontend development"
echo "  - .NET 9 SDK for backend development"
echo ""
echo "Port forwarding configured for:"
echo "  - Angular app: http://localhost:4200"
echo "  - .NET API: http://localhost:5000 & https://localhost:5001"
echo "  - Azure Functions: http://localhost:7071"
echo ""