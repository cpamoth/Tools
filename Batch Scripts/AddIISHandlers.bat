REM : Add Handler Mappings in IIS for webserver. Author : Jimmy George , Last Updated : Sep-21-2015

@echo off
setlocal
CLS
COLOR
IF "%1"=="" GOTO ParamMiss  rem HandlerType eg : svc
SET HandlerType=%1
REM get the full path to %App_cmd% from the system path : 
SET App_cmd=%windir%\system32\inetsrv\appcmd.exe
SET msg=" "
REM ######### END VARIABLE SECTION PLEASE DO NOT CHANGE ANYTHING BELOW  THIS LINE !! #######################
ECHO: HandlerType = %HandlerType%
if not exist %App_cmd% (
SET msg= "Appcmd.exe file not found at  "%App_cmd%". Please make sure you have IIS and Appcmd.exe in this path.. Exiting execution.. Or manually add the Handler Mappings in IIS"
GOTO ERROR
) 
echo. 
echo "Displaying all %HandlerType% Handler mappings :"
echo.
%systemroot%\system32\inetsrv\appcmd.exe list config -section:handlers | findstr .%HandlerType%

if /I '%HandlerType%'== 'svc' (
ECHO:
echo "Adding 2 Handler Mapping to the WebServer Config for %HandlerType% Handlers"
%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/handlers "/+[name='%HandlerType%-Integrated-4.0',path='*.%HandlerType%',verb='*',type='System.ServiceModel.Activation.ServiceHttpHandlerFactory, System.ServiceModel.Activation, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35']" /commit:apphost
echo.
%systemroot%\system32\inetsrv\appcmd.exe set config /section:system.webServer/handlers "/+[name='%HandlerType%-Integrated',path='*.%HandlerType%',verb='*',type='System.ServiceModel.Activation.HttpHandler, System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089']" /commit:apphost
echo.
echo "Adding 2 Script Maps to the WebServer Config for %HandlerType% Handlers"
echo.
%systemroot%\system32\inetsrv\appcmd set config /section:system.webServer/handlers "/+[name='%HandlerType%-ISAPI-4.0_32bit',path='*.%HandlerType%',verb='*',modules='IsapiModule',scriptProcessor='%windir%\Microsoft.NET\Framework\v4.0.30319\aspnet_isapi.dll']" /commit:apphost
%systemroot%\system32\inetsrv\appcmd set config /section:system.webServer/handlers "/+[name='%HandlerType%-ISAPI-4.0_64bit',path='*.%HandlerType%',verb='*',modules='IsapiModule',scriptProcessor='%windir%\Microsoft.NET\Framework64\v4.0.30319\aspnet_isapi.dll']" /commit:apphost
echo.
GOTO EOF
)
if /I '%HandlerType%'== 'asp' (
    ECHO:
    echo "Adding 1 Script Maps to the WebServer Config for %HandlerType% Handlers. For ClassicASP"
    %systemroot%\system32\inetsrv\appcmd set config /section:system.webServer/handlers "/+[name='ASPClassic',path='*.%HandlerType%',verb='*',modules='IsapiModule',scriptProcessor='%windir%\system32\inetsrv\asp.dll']" /commit:apphost
    GOTO EOF
)
) else (
	ECHO:
	ECHO "Invalid HandlerType"
	GOTO ERROR
)
echo.
echo "Done"
GOTO EOF

:ERROR
COLOR 0C
ECHO:
echo *error* ERROR Occured !. Error message : %msg%
echo Syntax  : AddIISHandlers.bat HandlerType
echo Example : AddIISHandlers.bat svc
ECHO:
echo.
title done
exit /b 1

:ParamMiss
ECHO:
echo *ERROR* Parameter missing !. Syntax  : AddIISHandlers.bat HandlerType
ECHO:
echo Example : AddIISHandlers.bat svc
echo.
ECHO:
title done
exit /b 1

:: End of batch file
:EOF
ECHO:
echo "Displaying all %HandlerType% Handler mappings after execution :"
echo.
%systemroot%\system32\inetsrv\appcmd.exe list config -section:handlers | findstr .%HandlerType%
echo End of batch execution..
title done
endlocal
