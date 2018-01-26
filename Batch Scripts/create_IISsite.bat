@echo off
setlocal

REM   Creates   IIS 7 Site with App pools and  configurations. Set the below variables to your requirements and execute this script to create IIS WebSite with App Pool :
REM : Author : Jimmy George , Last Updated : Nov-18-2011
REM : ###### *ComandLine Args required * Syntax  : create_IISsite.bat SiteName  Appool_UserName  Appool_Password  FolderPath  ENV
ECHO:

REM : Name the site name that will be used to create App pools and web site name Eg : "Elink SiteB" : 
IF "%1"=="" GOTO ParamMiss  rem SiteName
IF "%2"=="" GOTO ParamMiss  rem Appool_UserName
IF "%3"=="" GOTO ParamMiss rem  Appool_Password
IF "%4"=="" GOTO ParamMiss rem FolderPath
IF "%5"=="" GOTO ParamMiss rem ENV

SET SiteName=%1
REM : Path of App Pool for site is same same site name but wil be suffixed with a slash "/" Eg : "Elink SiteB/"  : 
SET Appool_SitePath="%SiteName%/"

SET Env=%5
REM HostHeader_Site should be prefixed wth the evn like <Env><SiteName> :
SET HostHeader_Site="%Env%%SiteName%"
REM : App Pool Name : 
SET Appool="%SiteName%"
REM : UserName and Password to be used for Appool Identity [use the gox login and password] : eg userName:"geninfo]\deveqweb3usr"  and password : "917ChpnRd"
SET Appool_UserName="%2"
SET Appool_Password="%3"

REM : "v2.0" or "v4.0" :
SET RuntimeVersion="v4.0"
REM : "Classic" or "Integrated" : 
SET PipelineMode="Integrated"
REM : Path to the WWW files  eg : "E:\Web\<foldername>"
REM SET FolderPath="E:\Web\%SiteName%"
SET FolderPath="%4"
REM : Bindings format : Protocol/IP:PORT:HOSTHEADER :
SET Bindings="HTTP/*:80:%HostHeader_Site%"
echo %msg%

REM ######### END VARIABLE SECTION PLEASE DO NOT CHANGE ANYTHING BELOW  THIS LINE !! #######################

REM get the full path to %App_cmd% from the system path : 
SET App_cmd=%windir%\system32\inetsrv\appcmd.exe
SET msg=" "

ECHO Please Use this script to create an IIS web site on IIS7 [it will NOT work on IIS6 or earlier].
ECHO Creating website with these following values : 
ECHO: 
ECHO: SiteName = "%SiteName%" 
ECHO: 
ECHO: Appool = %Appool% 
ECHO: 
ECHO: Appool_UserName = %Appool_UserName%  , Appool_Password=%Appool_Password%
ECHO: 
ECHO: Appool_SitePath = %Appool_SitePath% 
ECHO: 
ECHO: RuntimeVersion = %RuntimeVersion% 
ECHO: 
ECHO: PipelineMode = %PipelineMode% 
ECHO: 
ECHO: FolderPath = %FolderPath% 
ECHO: 
ECHO: Bindings / HOSTHEADER = %Bindings%
ECHO:
ECHO: 
ECHO Press any key to proceed with Web Site creation using above settings.. OR CTRL+C to Cancel this process...
ECHO ..............................................................................................................................................
ECHO:
ECHO:
pause
REM : Verifications..
if not exist %App_cmd% (
SET msg= "Appcmd.exe file not found at  "%App_cmd%". Please make sure you have IIS and Appcmd.exe in this path.. Exiting execution.."
GOTO ERROR
) 

if not exist %FolderPath% (
SET msg= "FolderPath  %FolderPath% does NOT Exists!. Please make sure to install the msi first to deploy the files.. Then run this script."
GOTO ERROR
) 
 ECHO *1. Creating App Pool .. 
%App_cmd% add apppool /name:%Appool% /managedRuntimeVersion:%RuntimeVersion% /managedPipelineMode:%PipelineMode%
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO:
ECHO:
ECHO *2. Creating IIS website .. 
%App_cmd% add site /name:%SiteName% /physicalPath:%FolderPath% /bindings:%Bindings%
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO:
ECHO:
ECHO *3. Adding App Pool to the new web site %SiteName%.. 
%App_cmd% set app %Appool_SitePath% /applicationPool:%Appool%
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO:
ECHO:
REM To add a "Default Document" to the site : 
REM %App_cmd% set config %SiteName% /section:defaultDocument /enabled:true /+files.[value='QLogin.aspx'] 

ECHO Disabling Anonymous Authentication for a site %SiteName%..
%App_cmd% set config %SiteName% -section:system.webServer/security/authentication/anonymousAuthentication /enabled:"False" /commit:apphost
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO Setting Appool Identify for Appool %Appool% ..
%App_cmd% set apppool /apppool.name:%Appool% -processModel.identityType:SpecificUser -processModel.userName:%Appool_UserName% -processModel.password:%Appool_Password%
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO:
ECHO ====================================================================================================================================
ECHO "Successfully set the Appool to disable "Anonymous Authentication".
ECHO And set the Appool Identity with UserName : %Appool_UserName% and Password : %Appool_Password%"
ECHO ====================================================================================================================================
ECHO:

ECHO *4. Starting web site %SiteName% .. Please press any key to start this website..:
pause
%App_cmd% start site %SiteName%
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)

ECHO:
ECHO:
ECHO Listing App Poool of site %SiteName%
%App_cmd% list apppool /apppool.name:%Appool%
ECHO:
ECHO:
ECHO Listing "Default Documents" of site %SiteName% : 
%App_cmd% list config %SiteName% -section:defaultDocument
ECHO:
ECHO ********** Site Configuratoion Completed Successfully for Site %SiteName% ***************
ECHO:

ECHO Listing All Sites on IIS : 
ECHO:
%App_cmd% list sites
ECHO:
ECHO:
ECHO -------------------------------------------------------------------
ECHO Listing All App Pools on IIS : 
ECHO:
%App_cmd% list apppool
ECHO:
ECHO:
ECHO -------------------------------------------------------------------
ECHO DONE !. Successfully created and configured with web site name : %SiteName% 
ECHO:
ECHO:
COLOR 0A
GOTO EOF

:SYSTEMERROR
ECHO:
COLOR 0C
echo *error* ERROR Occured !. Errorlevel is now: %ERRORLEVEL%.
ECHO:
ECHO:
ECHO Listing All Sites on IIS : 
%App_cmd% list sites
ECHO:
ECHO:
ECHO -------------------------------------------------------------------
ECHO Listing All App Pools on IIS : 
%App_cmd% list apppool
ECHO:
ECHO:
ECHO -------------------------------------------------------------------
ECHO:
title done
exit /b 1
    
:ERROR
COLOR 0C
ECHO:
echo *error* ERROR Occured !. Error message : %msg%
echo.
title done
exit /b 1

:ParamMiss
ECHO:
echo *ERROR* Parameter missing !. Syntax  : create_IISsite.bat SiteName  Appool_UserName  Appool_Password  FolderPath  ENV
ECHO:
echo Example : create_IISsite.bat DrugTestResult   geninfo\%ComputerName%usr   917ChpnRd  E:\Web\DrugTestResult  Dev
echo.
ECHO:
title done
exit /b 1

:: End of batch file
:EOF
ECHO:
echo End of batch execution..
title done
endlocal
