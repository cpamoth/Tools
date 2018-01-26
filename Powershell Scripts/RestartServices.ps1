# Script to Stop/Restart EQApp and EQAsync services.
# To execute example to restart pass a r parameter like : powershell.exe -ExecutionPolicy ByPass -File "E:\Tools\RestartServices.ps1" r
# 'cmd /c powershell.exe -ExecutionPolicy ByPass -File "E:\\Tools\\RestartServices.ps1" r'
if($args.Length -eq 0){
	$Stop = "n"
	$Start = "n"
	Write-Host 'You have not told me what to do.  r, stop, or start.'
	Write-Host 'r - restart everything'
	Write-Host 'stop - stop everything'
	Write-Host 'start - start everything'
	Write-Host
	Write-Host 'I will restart IIS and diplay the last process start times though.'
	Write-Host
}

if($args[0] -eq "r"){
	Write-Host
	Write-Host 'Restarting services and IIS'
	Write-Host
	$Stop = "y"
	$Start = "y"
}

if($args[0] -eq "stop"){
	$Stop = "y"
	$Start = "n"
}

if($args[0] -eq "start"){
	$Stop = "n"
	$Start = "y"
}

#Define Services 
$Service1 = 'AsyncProcessorService'
$Service2 = 'AsyncMonitorService'
$Service3 = 'Case Monitor'
$Service4 = 'CaseMonitor'
$Service5 = 'ServiceResolution'

$Services = @(
     $Service1,
	 $Service2,
	 $Service3,
	 $Service4,
	 $Service5)
	 
#Define Processes 
$Proc1 = 'Gis.eQPlusCase.Monitor.Service'
$Proc2 = 'Microsoft.ApplicationBlocks.AsynchronousInvocation.Monitorservice'
$Proc3 = 'Microsoft.ApplicationBlocks.AsynchronousInvocation.ROHService'
$Proc4 = 'Microsoft.ApplicationBlocks.AsynchronousInvocation.ROHService'
$Proc5 = 'Gis.eQuestPlus.ServiceResolution'
	
$Procs = @(
     $Proc1,
	 $Proc2,
	 $Proc3,
	 $Proc4,
	 $Proc5)

if($Stop -eq "y")
{
	Write-Host
	Write-Host 'Stopping services'
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
		Start-Sleep -s 10
}

if($Start -eq "y")
{ 
	Write-Host
	Write-Host 'Starting services'
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
		Start-Sleep -s 10
}

Write-Host
Write-Host 'Resetting IIS...'	
Write-Host 
invoke-command -scriptblock {iisreset}


Write-Host
Write-Host 'Here are the last start times for the Processes...'	
Write-Host 

Foreach($p in $Procs) {
	Get-Process -computername $env:COMPUTERNAME | Where-Object { $_.name -like $p } | select name, starttime
}

Write-Host
Write-Host 'Process Complete.'
Write-Host