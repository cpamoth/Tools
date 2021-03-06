param ([string]$login, [string]$pass, [string]$appName, [string]$iisAppPoolDotNetVersion, [string]$directoryPath, [string]$parentSite, [string]$reinstall) 

### for Testing purpose...  
###      .\NWCreateSite.ps1 geninfo\auto1svc8-1usr LCPassword%1 GISPANGEA 4.0 E:\WebRoot\GISPANGEA Base y



#Clear the Screen
cls

Import-Module WebAdministration



#navigate to the app pools root
cd IIS:\AppPools


if (Test-Path $appName)
 {
   
 ########################################################################
 #    Stop app pool 1st then Delete the Site and then app pool          #
 ########################################################################

    $state = $(Get-WebAppPoolState $appName) 

    Write-Host
    Write-Host "Reviewing $appName configuration..."

    if($reinstall -eq "y")
     {
	    Write-Host
	    Write-Host "I've been instructed to delete and recreate the application."
        Write-Host
	    Write-Host "Deleting the Application Pool and Web Application..."
        Write-Host

	    #If(!(get-WebAppPoolState -name $appName).Value -eq "Stopped")
         if((Get-WebAppPoolState $appName).Value -eq 'Stopped')
	     {

            Write-Host "($appName) app pool have already been stopped"
            Write-Host
	     }
            else 
         {
            Stop-WebAppPool -Name $appName
            Write-Host "Stopping $appName App Pool"
            Write-Host
         }


         if (Test-Path "IIS:\Sites\Base\${appName}") 
         {
            Write-Host "Deleting ${appName} Web Application from the ${parentSite} Site"
	        Remove-WebApplication -Name $appName -Site $parentSite
            Write-Host

         }
            else
         {
	        Write-Host "Web Application ${parentSite}\${appName} doesn't exist"
            Write-Host
	        Write-Host "Preparing to delete the App Pool now"
            Write-Host
         }      
                    
        if (Test-Path "$appName")
         {
            Write-Host "Deleting ${appName} Application Pool.... "
            Write-Host
            Remove-WebAppPool $appName
            Write-Host "*******  Deletion completed for $appName  *******"
         }

     }
		else 
	 {      
         if($reinstall -eq "n")
          {
            Write-Host "The reinstall status is showing ""$reinstall"" that means do not recreate App Pool and Site. So there is nothing to do here."
          } 
            else
          {
              Write-Host "The application pool ($appName) does not exist."
          }
	}
}


Write-Host
Write-Host



########################################################################
#                           Create App Pool                            #
########################################################################


Write-Host
Write-Host "Attempting to create the site..."
Write-Host
Write-Host "Searching for application pool $appName..."
Write-Host

if (!(Test-Path $appName -pathType container))
 {
        Write-Host "$appName does not exist.  Creating App Pool now..."
        Write-Host
        $appPool = New-Item $appName
		
        ### FRAMEWORK Version
		$appPool | Set-ItemProperty -Name "managedRuntimeVersion" -Value $iisAppPoolDotNetVersion
		
		###NetworService = 2 or ApplicationPoolIdentity = 3
        $appPool | Set-ItemProperty -Name "processModel.identityType" -Value 2 
 }
    else
 {
	    Write-Host "Appl pool $appName already exists.  Nothing to do here. Please review the IIS"
        return
 }
  

if (Test-Path $appName -pathType container)
 {
        Write-Host "Application pool $appName successfully created."
 }
    else
 {
        Write-Host "FAILED --->>>>   Failed to create application pool ${appName}."
        return
 }

# Wait few second before creating site. Give it enough time for App to start running.
Start-Sleep -s 3


########################################################################
#                            Create Site                               #
########################################################################

#navigate to the sites root
cd IIS:\Sites\$parentSite

#check if the site exists
Write-Host
Write-Host "Searching for $appName application on $parentSite site..."
Write-Host

if (Test-Path $parentSite -pathType container)
 {
    Write-Host "Application $parentSite already exists.  Nothing to do here."
    return
 }
    else
 {
     #check if the directory exists
     if ((Test-Path $directoryPath) -eq $False) 
      {
            Write-Host "FAILED --->>>>    $directoryPath does not exists. Please check the folder or your spelling."
            return
	  } 
        else
      {
            Write-Host "$appName doesn't exist.  Creating it now..."
            Write-Host
            $iisApp = New-WebApplication -Name $appName -Site $parentSite -physicalPath $directoryPath  -ApplicationPool $appName -Force
      }
 }

if (Test-Path $appName -pathType container)
{
    Write-Host "*******  Application $appName successfully created.  *******"
    return
}
else
{
	Write-Host "FAILED --->>>>   Failed to create application ${appName}."
    return
}
