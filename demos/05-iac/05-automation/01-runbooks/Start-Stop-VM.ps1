[cmdletbinding()]
param(
    [ValidateSet('start','stop')]
    [Parameter(Mandatory=$true)]
    [string]$Action,
    [Parameter(Mandatory=$true)]
    [string]$VMName,
    [Parameter(Mandatory=$true)]
    $ResourceGroupName
)
#Connect to Azure using the Run As Account
Try{
    $servicePrincipalConnection=Get-AutomationConnection -Name AzureRunAsConnection
    Add-AzureRmAccount -ServicePrincipal -TenantId $servicePrincipalConnection.TenantId -ApplicationId $servicePrincipalConnection.ApplicationId -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint
}
Catch {
    if (!$servicePrincipalConnection){
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}
#Actual Code to start/stop virtual machines
Switch($Action){
    'Start'{
        Start-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName -verbose
    }
    'Stop'{
        Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName -force -verbose
    }
}