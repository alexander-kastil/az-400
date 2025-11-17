# Chocolatey

[Chocolatey](https://chocolatey.org/)

## Demo

- Explain `setup-az-400.ps1` from `/Setup`
- Explain [Custom Script Extension for Windows](https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows). Mention Linux version.

>Note: As an alternative you can execute the command below:

```bash
az vm run-command invoke  --command-id RunPowerShellScript -n $vm -g $grp --scripts @setup-az-400.ps1 
```