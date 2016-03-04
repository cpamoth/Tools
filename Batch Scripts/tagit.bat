@echo off
setlocal

if "%1"=="" goto USAGE
set code_move=%1

echo.
echo.
GreenText Checking to see if everything has been committed before tagging..."
echo.
echo.
svn status
echo.
echo.
RedText "Be sure you have run CLEANUP on this main Code Move Directory before TAGGING this Directory..."
echo.
echo.
GreenText "Press Ctrl+C to cancel this process or..."
PAUSE

set basedir=C:\SVN\Gis\Development\DatabaseProjects\
set tagbasedir=C:\SVN\Gis\Development\DatabaseProjects\Tags\
set code_move_tag_dir=C:\SVN\Gis\Development\DatabaseProjects\Tags\Code Move 
set cmtext="Code Move "

echo.
echo.
if not exist "%code_move_tag_dir%%1%" (
	goto TAGIT
) ELSE (
	goto RETAGIT
)
echo.
echo.

:RETAGIT

echo.
echo.
RedText "The TAG Directory for this Code Move Exists!. RE-Tagging this Code Move..."
echo.
echo.
pushd %tagbasedir%
rd /s/q %cmtext%%code_move%
svn delete %cmtext%%code_move%
svn commit -m "Retagging"
echo.
echo.
RedText "Removed Existing Tags direcetory for this Code Move"
echo.
echo.

goto TAGIT

:TAGIT

echo.
echo.
GreenText "Tagging this Code Move..."
echo.
echo.
echo.
echo.
greenText "Updating DatabaseProjects..."
echo.
echo.
pushd "C:\SVN\Gis\Development\DatabaseProjects"
svn update

pushd "Code Move %code_move%"

svn info | findstr URL > ..\x

pushd ..

for /f "tokens=2" %%i in (x) do (
    svn copy %%i "Tags\Code Move %code_move%" 
    svn commit -m "Create Tag for %code_move%"
)

del x

popd

echo.
echo.
GreenText "Updating Tags..."
echo.
echo.
pushd "..\Tags"
svn update

pushd "Code Move %code_move%"
call getf.bat

popd
popd
popd
popd
popd
pushd "C:\SVN\Gis\Development"

echo.
echo.
GreenText Done!
echo.
echo.

goto EOF

:USAGE

echo %0 code_move

:EOF
endlocal
