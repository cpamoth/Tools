@echo off
Rem  ---------------------------------- Script Info   -----------------------------------------------------------
Rem :  STOP async processor , async monitor , case monitor and IIS services on Q2 DEV2eqasync1, DEV2eqasync2, DEV2eqapp1 and DEV2eqapp2  boxes.. Fro Al fulton's email service issue
Rem Author : Jimmy George. Last updated : Jan-26-2012
Rem  ----------------------------------END Script Info   -----------------------------------------------------------

echo STOPING "async processor" , "async monitor" , "case monitor" and IIS services on DEV2eqapp1.
@echo on
sc stop "AsyncProcessorService"
rem sleep for 3 seconds :
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "AsyncMonitorService"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "Case Monitor"
@ping 127.0.0.1 -n 8 -w 1000 > nul

@ping 127.0.0.1 -n 10 -w 1000 > nul


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