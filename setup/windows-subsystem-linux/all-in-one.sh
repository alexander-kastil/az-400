sudo apt update

# node & azure cli
sudo apt-get install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
sudo apt-get install build-essential
nvm install 20.12.2
nvm install 18.19.1
nvm use 20.12.2
npm install -g @angular/cli

# .net
wget https://packages.microsoft.com/config/ubuntu/20.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get install -y apt-transport-https && \
sudo apt-get update && \
sudo apt-get install -y dotnet-sdk-8.0

# azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az config set extension.use_dynamic_install=yes