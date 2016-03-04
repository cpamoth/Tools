@echo off
setlocal

svn update --set-depth=infinity

goto EOF

:USAGE

echo %0

:EOF
endlocal
