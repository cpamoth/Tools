@echo off
setlocal

svn update --set-depth=immediates

goto EOF

:USAGE

echo %0

:EOF
endlocal
