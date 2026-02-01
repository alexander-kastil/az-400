# Install tools via winget (simple sequential installs)
winget --accept-package-agreements --accept-source-agreements install --id Git.Git -e
winget --accept-package-agreements --accept-source-agreements install --id Google.Chrome -e
winget --accept-package-agreements --accept-source-agreements install --id Microsoft.VisualStudioCode -e
winget --accept-package-agreements --accept-source-agreements install --id Microsoft.AzureCLI -e
winget --accept-package-agreements --accept-source-agreements install --id Microsoft.VisualStudio.2022.BuildTools -e
winget --accept-package-agreements --accept-source-agreements install --id Microsoft.DotNet.SDK.10 -e

# Install Node 22.12.0
$nodeVersion = '22.12.0'
$nodeMsiUrl = "https://nodejs.org/dist/v$nodeVersion/node-v$nodeVersion-x64.msi"
$nodeMsiPath = Join-Path $env:TEMP "node-v$nodeVersion-x64.msi"
Invoke-WebRequest -Uri $nodeMsiUrl -OutFile $nodeMsiPath
Start-Process msiexec.exe -ArgumentList "/i `"$nodeMsiPath`" /qn /norestart" -Wait

# Install Angular CLI 21
npm install -g @angular/cli@21
npx -y @angular/cli@21 analytics off

# Download and extract latest Azure Pipelines agent (simple)
$agentDir = 'C:\agents'
New-Item -ItemType Directory -Path $agentDir -Force | Out-Null
$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/microsoft/azure-pipelines-agent/releases/latest' -UseBasicParsing
$asset = $release.assets | Where-Object { $_.name -match 'vsts-agent-win-x64.*\.zip$' } | Select-Object -First 1
$zipUrl = $asset.browser_download_url
$zipPath = Join-Path $env:TEMP $asset.name
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $agentDir -Force

Write-Host "Agent extracted to $agentDir. Configure it by running .\config.cmd from the agent folder (interactive) or set AZP_URL and AZP_TOKEN and run: .\config.cmd --unattended --url <url> --auth pat --token <token> --pool <pool> --agent <name> --acceptTeeEula --runAsService" -ForegroundColor Green

