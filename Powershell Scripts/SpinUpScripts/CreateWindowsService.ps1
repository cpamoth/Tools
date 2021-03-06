param([string]$login, [string]$pass, [string]$serviceName, [string]$binaryPath, [string]$reinstall)

Write-Host
Write-Host "Validating executable path at ${binaryPath}..." 
if(!(Test-Path $binaryPath -pathType leaf))
{
    Write-Host "Could not find a valid executable at ${binaryPath}!"
    return
}
Write-Host "$binaryPath exists."

    $service = Get-WmiObject -Class Win32_Service -Filter "Name='$serviceName'"
    if($service)
    {   
        if($reinstall -eq "y")
        {
            Write-Host
			Stop-Service $serviceName
            Write-Host "Deleting ${serviceName}..." 
            $service.delete()
        }
        else
        {
            Write-Host
            Write-Host "${serviceName} already exists.  Nothing to do here."
            return
        }
    }

Write-Host
Write-Host "installing service..."
# creating credentials which can be used to run my windows service
$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("geninfo\$login", $secpasswd)

# creating windows service using all provided parameters
$svc = New-Service -name $serviceName -binaryPathName $binaryPath -displayName $serviceName -startupType Automatic -credential $mycreds

#test service installation
if($svc)
{
    Write-Host
    Write-Host "installation complete."
    Write-Host
    Write-Host "starting ${serviceName}..."
    Start-Service $serviceName
}
else
{
    Write-Host
    Write-Host "installation failed!"
}
