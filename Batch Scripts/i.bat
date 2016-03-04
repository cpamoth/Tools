@echo off
msiexec /i %~n1.msi /l*v %~n1.log ENVIRONMENT=DEV
echo %date% %time% - Installed %~n1.msi >> E:\DeploymentLog.log
echo %date% %time% - Installed %~n1.msi