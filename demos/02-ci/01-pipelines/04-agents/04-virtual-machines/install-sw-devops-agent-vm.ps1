function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}

Disable-InternetExplorerESC

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install SDKS und Tools
choco install googlechrome -y
choco install vscode -y
choco install git -y
choco install azure-cli -y
choco install azurepowershell -y
choco install dotnetcore-sdk -y
choco install dotnet-6.0-sdk -y
choco install visualstudio2019buildtools -y
choco install nodejs --version=14.15.0 -y

# Install Azure DevOps Agent
choco install azure-pipelines-agent --params "'/Directory:c:\agent'" -y

# Refresh Path Env for npm 
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
refreshenv

# Node based toools
npx @angular/cli@latest analytics off
npm i -g @angular/cli@14
npm i -g gulp
