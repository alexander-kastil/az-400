# replace token with your own value
$devopstoken = 'lz4w2...'
.\config.cmd --unattended --pool "win-selfhosted" --agent $env:COMPUTERNAME --runasservice --work '_work' --url 'https://dev.azure.com/integrationsonline/' --projectname 'az-400' --auth PAT --token $devopstoken