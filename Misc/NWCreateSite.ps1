param ([string]$login, [string]$pass, [string]$appName, [string]$iisAppPoolDotNetVersion, [string]$directoryPath, [string]$parentSite, [string]$reinstall) 

Import-Module WebAdministration

#navigate to the app pools root
cd IIS:\AppPools

Write-Host
Write-Host "Searching for $appName configuration..."

if($reinstall -eq "y")
{
	Write-Host
	Write-Host "I've been instructed to delete and recreate the application."
    Write-Host
	Write-Host "Attempting to delete the site..."
	Write-Host "Stopping $appName"
	If(!(get-WebAppPoolState -name $appName).Value -eq "Stopped")
	{
		Stop-WebAppPool -Name $appName
	}
	Write-Host "Deleting ${parentSite}\${appName}"
	Remove-WebApplication -Name $appName -Site $parentSite
	Write-Host "Deleting application pool $appName"
	Remove-WebAppPool $appName
	Write-Host "Deletion complete"
}

Write-Host
Write-Host "Searching for application pool $appName..."
if (!(Test-Path $appName -pathType container))
{
    Write-Host "$appName doesn't exist.  Creating it now..."
    $appPool = New-Item $appName
    $appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
    $appPool | Set-ItemProperty -Name "processModel.identityType" -Value 2 #2 is NetworService
}
else
{
	Write-Host "Application pool $appName already exists.  Nothing to do here."
    return
}

if (Test-Path $appName -pathType container)
{
    Write-Host "Application pool $appName successfully created."
}
else
{
    Write-Host "Failed to create application pool ${appName}."
    return
}

#navigate to the sites root
cd IIS:\Sites\$parentSite

#check if the site exists
Write-Host
Write-Host "Searching for application $appName..."
if (Test-Path $appName -pathType container)
{
    Write-Host "Application $appName already exists.  Nothing to do here."
    return
}
else
{
	Write-Host "$appName doesn't exist.  Creating it now..."
	$iisApp = New-Item $appName -physicalPath $directoryPath -type "Application"
	Write-Host "Setting application pool to $appName"
	Set-ItemProperty $appName ApplicationPool $appName
}

if (Test-Path $appName -pathType container)
{
    Write-Host "Application $appName successfully created."
    return
}
else
{
	Write-Host "Failed to create application ${appName}."
    return
}
