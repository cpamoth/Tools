@echo off
REM : Batch script to build a generic project. Can build from any Project folder : USAGE  BuildProject.bat
REM : Author : Jimmy George , Last Updated : Sep-26-2011

setlocal
title Executing Batch script to build a generic project. Can build from any Project folder.
ECHO IMPORTANT ! : For Elink execute "elinklight.bat" script Please do NOT use this script !. Press CTRL+C to cancel this or press any key to proceed..
pause
ECHO:ECHO:

SET RootFolder=C:\SVN\Gis\Development
SET /P ProjectFolder=Enter Relative Project Folder path without Quotes. Eg : "Core Applications\ComplI9Alerter v2.0"  : %=%
SET FullProjectPath="%RootFolder%\%ProjectFolder%"
SET MSIFilePath="%RootFolder%\%ProjectFolder%\Install\Bin\Release\*.msi

ECHO Verifying if the ProjectFolder %FullProjectPath% folder exists..
if not exist %FullProjectPath% (
SET msg= "Project FolderPath  %FullProjectPath% does NOT Exists!. Please make sure this path exists. Can you perform "svn update" from the main project folder to get the latest project folders from SVN.. And then run this script. Exiting execution"
GOTO ERROR
) 

popd
popd
popd
REM Goto C:\ Root 
cd \ 
echo executing go svn
CALL go.bat svn
cd

echo Performing "pushd" to "%ProjectFolder%" folder.
pushd "%ProjectFolder%"
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO Current Directory is :
cd

ECHO:ECHO:
echo Performing a getf in "%ProjectFolder%" Project folder to get the latest files from SVN..
CALL GetF.bat
echo Completed getf.
ECHO:ECHO:

IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO Listing all files in "%ProjectFolder%"  folder.
dir

ECHO Changing directory to cd "Project Code"..
cd "Project Code"
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
cd
ECHO:
ECHO Listing all files in "Project Code" folder ..
dir
ECHO:
ECHO ........ Listing build file ...............
ECHO:
dir *ld
ECHO:
SET /P buildfilename=Please Enter the ".build" from above displayed list : 
if not exist "%buildfilename%" (
	SET msg= "Build FileName that you entered does NOT Exists!. Please make sure this build filename is correct !. Exiting execution"
	GOTO ERROR
) 

ECHO:
ECHO:
REM Prompt for .NET Framework to use to build..
SET /P netver=Use .NET Framework 4 [Y/N] . (Note : If you enter "N" then it will be build using .NET 3.5 Framework) ? :
if /I '%netver%'== 'Y' (
	ECHO:
	ECHO Building project file "%buildfilename%"  with NET Version Framework 4 .. Plesae any key to confirm or CTRL+C to cancel the process..
	ECHO:
	pause
	ECHO Executing command "MSBuild.exe %buildfilename%".
	MSBuild.exe %buildfilename%
	IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
) else (
	ECHO:
	ECHO Building project file "%buildfilename%"  with NET Version Framework 3.5.. Please any key to confirm or CTRL+C to cancel the process..
	ECHO:
	pause
	ECHO Executing command "%buildfilename%".
	%buildfilename%	
	IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
)

ECHO:
ECHO Completed building the Project with MSBuild and generating the msi.. Verifying the msi file at %MSIFilePath%"

if not exist %MSIFilePath%" (
SET msg= "MSI file  %MSIFilePath%" does NOT Exists!.. Please make sure build was successfull... Exiting execution"
GOTO ERROR
) 

ECHO Executing command : "svn info %MSIFilePath%"
svn info %MSIFilePath%

popd
cd 
ECHO:
ECHO Changed Directory to root Development directory and executing "prep.bat"
CALL prep.bat
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)
ECHO:
ECHO prep execution completed. Please modify the x.bat file as needed , save and close And Then press any key to execute the x.bat..
pause
ECHO:
ECHO:

REM Delete x.bat if exists :
if  exist x.bat (
	ECHO Executing x.bat..
        CALL x.bat
       REM 	IF ERRORLEVEL 1 (GOTO SYSTEMERROR)	
      ECHO Executed x.bat.. Press any key to proceed
      pause
      )
      if  exist x.bat (
          del x.bat
	  ECHO Deleted x.bat..
     )
)
ECHO:
ECHO:

ECHO Executing command : "svn info %MSIFilePath%
svn info %MSIFilePath%

ECHO *** IMPORTANT ! : IF USING BandIWeb_v2, ComplI9, Elink, NachoLibre [any svn path with "Gis.CrimDevelopedService"]  
ECHO THEN YOU NEED TO USE "TRACKER"  [Note "tracker will do "built" [build versioning , archieving to SVN for you].. 
ECHO:
SET /P usetracker=Does this project use Tracker [Y/N] ? :
if /I '%usetracker%'== 'Y' (
	ECHO:
	ECHO Exiting script so that you can continue with tracker.. 
	COLOR 0A
	GOTO EOF
)

ECHO:
ECHO Going to execute built.bat script. Press any key to commit to SVN. To CTRL+C To cancel.. [Note if you cancel then please make sure you run "revert ." from FullProjectPath : FullProjectPath]..
pause
ECHO Proceeding with to execute "built.bat" to commit files to SVN... Please wait..
CALL built.bat
IF ERRORLEVEL 1 (GOTO SYSTEMERROR)

ECHO Completed MSBuild.. You are ready to deploy the MSI file to remote box. 
ECHO:

ECHO:
ECHO:
echo ......................................................................................................................................................
echo Done. 
echo  ...........................................................................END batch execution --------------------------------
ECHO:
COLOR 0A
goto EOF

REM  ########## END main script section.  ###############################33


:SYSTEMERROR
ECHO:
COLOR 0C
echo * ERROR * : Errorlevel is now: %ERRORLEVEL%.
title done
ECHO:
ECHO:
exit /b 1

:ERROR
ECHO:
COLOR 0C
echo * ERROR * : Error message : %msg%
echo.
title done
exit /b 1

:EOF
ECHO:
title done
endlocal
