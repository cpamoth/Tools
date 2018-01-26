REM dir
REM pause

ECHO OFF
CLS
:MENU1
ECHO.
ECHO .................................................
ECHO PRESS 1 OR 2 to select your BROWSER or 3 to EXIT.
ECHO .................................................
ECHO.
ECHO 1 - Open Internet Explorer
ECHO 2 - Open Chrome
ECHO 4 - Open Firefox
ECHO 3 - Exit
ECHO.
SET /P M=Type 1, 2 or 3 then press ENTER:
IF %M%==1 (
set browser=internetexplorer
GOTO MENU2)
IF %M%==2 (
set browser=chrome
GOTO MENU2)
IF %M%==4 (
set browser=firefox
GOTO MENU2)
IF %M%==3 GOTO EOF
REM ***************************************

:MENU2
ECHO OFF
CLS
ECHO.
ECHO .....................................................
ECHO PRESS 1 OR 2 to select your ENVIRONMENT or 3 to EXIT.
ECHO .....................................................
ECHO.
ECHO 1 - DEV2
ECHO 2 - QA2
ECHO 3 - Exit
ECHO.
SET /P M=Type 1, 2 or 3 then press ENTER:
IF %M%==1 (
set RunEnvironment=Dev2
GOTO MENU3)
IF %M%==2 (
set RunEnvironment=qa2
GOTO MENU3)
IF %M%==3 GOTO EOF
REM ***************************************

:MENU3
ECHO OFF
CLS
ECHO.
ECHO ......................................................
ECHO PRESS 1, 2, 3 OR 4 to select your METHOD or 5 to EXIT.
ECHO ......................................................
ECHO.
ECHO I2_Test1 I2_Test2 I2_Test3
ECHO 1 - Select ALL
ECHO 2 - Select I2_Test1
ECHO 3 - Select I2_Test2
ECHO 4 - Select I2_Test3
ECHO 5 - Exit
ECHO.
SET /P M=Type 1, 2, 3, 4 or 5 then press ENTER:
IF %M%==1 (
set method=I2_Test1 || method == I2_Test2 || method == I2_Test3
GOTO RUN)
IF %M%==2 (
set method=I2_Test1
GOTO RUN)
IF %M%==3 (
set method=I2_Test2
GOTO RUN)
IF %M%==4 (
set method=I2_Test3
GOTO RUN)
IF %M%==5 GOTO EOF
REM ***************************************

:RUN
pushd \\geninfo.com\Files\ITG\AutomatedTesting\CRIMTestingDeveloperUse\nunit
del TestResult.xml
set browser=%browser%
set RunEnvironment=%RunEnvironment%
set method=%method%
nunit3-console.exe ..\GISAutomation.dll --where "method == %method%" /out:TestResult.xml /err:StdErr.txt
GOTO MENU
REM ***************************************

:EOF

REM !--<div class="dropdown">
REm   <button onclick="myFunction()" class="dropbtn">Dropdown</button>
REM   <div id="myDropdown" class="dropdown-content">
REM     <a href="#">Link 1</a>
REM     <a href="#">Link 2</a>
REM     <a href="#">Link 3</a>
REM   </div>
REM</div>-->
