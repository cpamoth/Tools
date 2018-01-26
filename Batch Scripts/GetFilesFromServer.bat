REM : Copy files from remote server to a share. Author : Jimmy George , Last Updated : Nov-23-2015
REM : Created to easily send files to dev from a server path.
REM : Eg GetFilesFromServer.bat qa2webint3 E:\Web TestApps  \\geninfo.com\files\ITG
@echo off
setlocal
CLS
COLOR
REM Servername eg : dev2webint3
IF "%1"=="" GOTO ParamMiss
REM RootFolder eg : E:\Web  This is for security reasons. Limit access to fetching files from E:\Web , E:\Services , E\Jobs folders only.
IF "%2"=="" GOTO ParamMiss
REM ServerFolder eg : eQuestPlus
IF "%3"=="" GOTO ParamMiss
REM SharePath eg : \\geninfo.com\files\ITG 
IF "%4"=="" GOTO ParamMiss
SET Servername=%1%
SET ServerUsrname=%1%usr
SET RootFolder=%2%
SET ServerFolder=%3%
SET SharePath=%4%
SET ServerFolderFullPath=%RootFolder%\%ServerFolder%
SET TempSharefolder=Tempfiles
REM Eg \\geninfo.com\files\ITG \Tempfiles
SET SharePath=%SharePath%\%TempSharefolder%
REM Eg \\geninfo.com\files\ITG \Tempfiles\QA2webInt2
SET TempShareServerPath=%SharePath%\%Servername%
REM Eg \\geninfo.com\files\ITG \Tempfiles\QA2webInt2\Notifications
SET TempShareServerFullPath=%SharePath%\%Servername%\%ServerFolder%
REM SET a local folder on BA server for staging prior Xcopying to  fileshare.
SET TempLocalFolder=E:\Temp\%Servername%
SET TempLocalFolderFullPath=E:\Temp\%Servername%\%ServerFolder%
SET bashpath=E:\tools\SSHTools\bin\bash.exe
SET CG=E:\Jobs\CommandGeneral\CommandGeneral.exe 
echo.
echo "ServerName = %ServerName%, ServerUsrname=%ServerUsrname% , RootFolder=%RootFolder%, ServerFolder=%ServerFolder%, SharePath=%SharePath%"
echo "TempShareServerPath=%TempShareServerPath% , TempShareServerFullPath=%TempShareServerFullPath% , TempLocalFolderFullPath=%TempLocalFolderFullPath%"
echo. 
ECHO [INFO] Checking if SharePath folder exists at "%SharePath%"
if not exist "%SharePath%" (
   ECHO [ERROR] Could not find share folder at "%SharePath%" Please make sure you entered a valid share  path
   GOTO EOF
) 
FOR /F "tokens=* USEBACKQ" %%F IN (`%CG% "--norc --noprofile -c \"/bin/cygpath -C UTF-8 '%RootFolder%'\"" buildatlas1 {P:TOOL:bash}`) DO (
SET cygRootFolder=%%F
)
REM if ServerFolder arg has an special chars then exit the program
echo %ServerFolder%| findstr /r "^[^\\/?%%*:|<>\.\"]*$^" > nul
REM echo errorlevel = %errorlevel%
if errorlevel 1 (
  echo Illegal chars entered for ServerFolder argument as "%ServerFolder%". Exiting.
  GOTO :ERROR
) 
REM if ServerFolder has a Dir arg value then display all the files under the RootFolder 
IF /I "%ServerFolder%"=="dir" GOTO ListDir  
REM Cleanup old files Delete files older than 7 days 
ECHO [INFO] Deleting files older than 7 days from "%SharePath%" 
PushD "%SharePath%" &&(
dir %SharePath%
forfiles -s -m *.* -d -7 -c "cmd /c del /q /f @path >nul 2>&1" 
) & PopD
REM Cleanup local folders  : E:\Jobs\CommandGeneral\CommandGeneral.exe "Remove-Item E:\TEMP\dev2webint3 -Force -Recurse -ErrorVariable errs -ErrorAction SilentyContinue" buildatlas1 {P:TOOL:powershell}
%CG% "Remove-Item %TempLocalFolder% -Force -Recurse -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
ECHO Cleanup of old files from %TempLocalFolder% completed.
REM End Cleanup process
ECHO [INFO]  Creating a temp folders on file share folder %TempShareServerFullPath%
if not exist %TempShareServerPath% (
	md %TempShareServerPath%
)
if not exist %TempShareServerFullPath% (
	md %TempShareServerFullPath%
)
ECHO [INFO]  Creating a temp local folder at %TempLocalFolderFullPath%"
REM Cleanup local folders  : E:\Jobs\CommandGeneral\CommandGeneral.exe "New-Item E:\TEMP\dev2webint3 -type directory -Force -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
%CG% "New-Item %TempLocalFolder% -type directory -Force -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
REM delay for 3 seconds
@ping 127.0.0.1 -n 3 -w 1000 > nul  
%CG% "New-Item %TempLocalFolderFullPath% -type directory -Force -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
REM E:\tools\SSHTools\bin\bash.exe --norc --noprofile -c "/usr/bin/cygpath -C UTF-8 \"E:\Web\Test""
REM CommandGeneral.exe "--norc --noprofile -c \"/usr/bin/cygpath -C UTF-8 'E:\Web\Test'\"" buildatlas1 {P:TOOL:bash}
REM get Cygwin cygServerFolder
FOR /F "tokens=* USEBACKQ" %%F IN (`%CG% "--norc --noprofile -c \"/bin/cygpath -C UTF-8 '%ServerFolderFullPath%'\"" buildatlas1 {P:TOOL:bash}`) DO (
SET cygServerFolderFullPath=%%F
)
echo "cygServerFolderFullPath = %cygServerFolderFullPath%"
REM get Cygwin TempLocalFolderFullPath
FOR /F "tokens=* USEBACKQ" %%F IN (`%CG% "--norc --noprofile -c \"/bin/cygpath -C UTF-8 '%TempLocalFolderFullPath%'\"" buildatlas1 {P:TOOL:bash}`) DO (
SET cygTempLocalFolderFullPath=%%F
)
echo "................."
echo "cygServerFolderFullPath = %cygServerFolderFullPath%"
echo "cygTempLocalFolderFullPath =  %cygTempLocalFolderFullPath%/"
echo "................."
IF "%cygServerFolderFullPath%"=="" GOTO ERROR  
REM cygpath conversion did not work
IF "%cygTempLocalFolderFullPath%"=="" GOTO ERROR  
REM cygpath conversion did not work
REM TEST
REM End TEST
echo "Performing RSync from Server : %ServerName% , ServerFolder : %cygServerFolderFullPath%  To BuildAtlas Server : %cygTempLocalFolderFullPath%"
%CG% "-apc --stats --delete --rsh=\"ssh -i {RSA}\" {P:ServerUser}@{P:Server}:%cygServerFolderFullPath% %cygTempLocalFolderFullPath%\"" %ServerName% {P:TOOL:rsync}
echo Granting permissions to temp local folder and files under %cygTempLocalFolderFullPath%
%CG% "--norc --noprofile -c \"/bin/cygpath chmod --silent -R 777 %cygTempLocalFolderFullPath%\"" buildatlas1 {P:TOOL:bash}
REM %CG% "icacls %cygTempLocalFolderFullPath% /grant:r Everyone:F" buildatlas1 {P:TOOL:cmd}
echo "Performing Xcopy from BuildAtlas Server folder : %TempLocalFolderFullPath% to Share at  %TempShareServerFullPath%"
REM eg E:\Temp\dev2webint3\\Notofications  to   \\geninfo.com\files\ITG\Tempfiles\dev2webint3\\Notofications
%CG% "%TempLocalFolderFullPath%\*.* /a /e /k /y /q %TempShareServerPath%" buildatlas1 {P:TOOL:xcopy}
echo "Displaying all transfered files under the copied share at after execution %TempShareServerFullPath% :"
dir %TempShareServerFullPath%
echo.
echo.
REM Cleanup local folders  : E:\Jobs\CommandGeneral\CommandGeneral.exe "Remove-Item E:\TEMP\dev2webint3 -Force -Recurse -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
%CG% "Remove-Item %TempLocalFolder% -Force -Recurse -ErrorVariable errs -ErrorAction SilentlyContinue" buildatlas1 {P:TOOL:powershell}
ECHO Cleanup of old files from %TempLocalFolder% completed.
echo.
echo "-----------------------------------------------------------------------------"
echo "Transfer completed."
echo "All files from %Servername% server at %ServerFolderFullPath% are transfered to the Share at  %TempShareServerFullPath% "
echo "-----------------------------------------------------------------------------"
echo.
GOTO EOF
:ListDir
echo.
echo Displaying folders and files under RootFolder %RootFolder% on Server %Servername%
REM E:\Jobs\CommandGeneral\CommandGeneral.exe "\"-i {RSA}\" {P:ServerUser}@{P:Server} 'ls -la /cygdrive/e/web'" dev2webint3 {P:TOOL:ssh}
%CG% "\"-i {RSA}\" {P:ServerUser}@{P:Server} 'ls -la %cygRootFolder%'" %ServerName% {P:TOOL:ssh}
GOTO EOF
:ERROR
COLOR 0C
ECHO:
echo *error* ERROR Occured !. Error message : %msg%
GOTO ParamMiss
exit /b 1

:ParamMiss
ECHO:
echo *ERROR* Parameter missing !.
ECHO:
echo Syntax  : GetFilesFromServer.bat Servername RootFolder ServerFileFolder SharePath 
echo Example : GetFilesFromServer.bat dev2webint3 E:\Web MVRMaintenance \\geninfo.com\files\ITG 
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