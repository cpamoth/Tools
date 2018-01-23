if($args.Length -eq 0){
	$Stop = "n"
	$Start = "n"
	Write-Host 'stop - stop everything'
	Write-Host 'start - start everything'
	Write-Host
	Write-Host
}

if($args[0] -eq "r"){
	Write-Host
	Write-Host 'Restarting Services'
	Write-Host
	$Stop = "y"
	$Start = "y"
}

if($args[0] -eq"stop"){
	$Stop = "y"
	$Start = "n"
}

if($args[0] -eq"start"){
	$Stop = "n"
	$Start = "y"
}

#Define Services 
##$Service1 = 'NW_JetsINS'
##$Service2 = 'NW_JetsHR'

	
##$Services = @(
     ##$Service1,
	 ##$Service2)
	 
#Define Processes 
##$Proc1 = 'GIS.Pangea.NW.ServiceHosts.NewWorld.exe'
##$Proc2 = 'GIS.Pangea.NW.ServiceHosts.NewWorld.exe'

	
##$Procs = @(
     ##$Proc1,
	 ##$Proc2)

if($Stop -eq "y")
{
	Write-Host
	Write-Host 'Stopping Services'
	Write-Host
	
	#Stop Services
	Get-service | 
		Where { $Services -Contains $_.Name} |
		Foreach {
			Write-Host 'Stopping '(Get-Service $_.Name).DisplayName'...'
			$_ | Stop-Service
		}
	
	Write-Host
	Write-Host 'Verifying all services have stopped...'
	Write-Host	
	
	#Verify Services
	Get-service | 
		Where { $Services -Contains $_.Name} |
		Foreach {
			if ((Get-Service $_.Name).Status -eq "stopped") {Write-Host (Get-Service $_.Name).DisplayName' Stopped'} else {Write-Host (Get-Service $_.Name).DisplayName' Failed to stop';Exit '1000'}
		}
}

if($Start -eq "y")
{ 
	Write-Host
	Write-Host 'Starting Services'
	Write-Host
	
	#Start Services
	Get-service | 
		Where { $Services -Contains $_.Name} |
		Foreach {
			Write-Host 'Starting '(Get-Service $_.Name).DisplayName'...'
			$_ | Start-Service
		}
		
	Write-Host
	Write-Host 'Verifying all services are running...'
	Write-Host

	#Verify Services
	Get-service | 
		Where { $Services -Contains $_.Name} |
		Foreach {
			if ((Get-Service $_.Name).Status -eq "running") {Write-Host (Get-Service $_.Name).DisplayName ' Running'} else {Write-Host (Get-Service $_.Name).DisplayName ' Failed to start';Exit '1000'}
		}
}


Write-Host
Write-Host 'Here are the last start times for the Processes...'	
Write-Host 

Foreach($p in $Procs) {
	Get-Process -computername $env:COMPUTERNAME | Where-Object { $_.name -like $p } | select name, starttime
}

Restart-Service NW_JetsHR

Restart-Service NW_JetsINS

Write-Host
Write-Host 'Process Complete.'
Write-Host