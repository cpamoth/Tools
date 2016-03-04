@echo off
setlocal

if "%1"=="" goto USAGE
set proj_file=%1

type %proj_file% | findstr /i "toolsversion"

goto EOF

:USAGE
echo %0 proj_file

:EOF
endlocal
