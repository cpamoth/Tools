@echo off
Rem  ---------------------------------- Script Info   -----------------------------------------------------------
Rem :  Start async processor , async monitor , case monitor and IIS services on   eqasync1,  eqasync2,  eqapp1 and  eqapp2  boxes.. Also For fix for Al fulton's email service issue
Rem Author : Jimmy George. Last updated : Jan-26-2012
Rem  ----------------------------------END Script Info   -----------------------------------------------------------

echo This script is for  eqasync1,  eqasync2,  eqapp1 and  eqapp2  boxes
echo Restarting "async processor" , "async monitor" , "case monitor" and IIS services.
@echo on
sc stop "AsyncProcessorService"
rem sleep for 3 seconds :
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc stop "AsyncMonitorService"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc stop "Case Monitor"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc start "AsyncProcessorService"
@ping 127.0.0.1 -n 3 -w 1000 > nul
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "AsyncMonitorService"
@ping 127.0.0.1 -n 3 -w 1000 > nul
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "Case Monitor"
@ping 127.0.0.1 -n 3 -w 1000 > nul
@ping 127.0.0.1 -n 3 -w 1000 > nul

iisreset
@echo off
IF NOT ERRORLEVEL 0 GOTO :ERR

ECHO:
ECHO:

GOTO END

:ERR
echo !Error. sqlcmd failed.

Echo Finished.
ECHO:
:END