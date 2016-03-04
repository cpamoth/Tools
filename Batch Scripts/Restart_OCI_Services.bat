@echo off
Rem  ---------------------------------- Script Info   -----------------------------------------------------------
Rem :  Start OCI Servics after deployment on DEVWINSERV1 for Michael Astrauckas "E:\Services\Gis.Application.Service.Oci" and "E:\Services\Gis.Application.Service.OciServices"
Rem Author : Jimmy George. Last updated : Feb-16-2012
Rem  ----------------------------------END Script Info   -----------------------------------------------------------

echo Restarting OCI Services ["Processes Oci Batch request. [BATCH]", "Sends Acknowledgement to Crim [CRIMACK]","Oci Interface Service [OCIService]", 
echo "Oci PosBak Service [POSBAK]","Oci Retriever [RETRIEVER]", "Oci Service [OCI]" on qa2eqapp1.
@echo on
sc stop "BATCH"
rem sleep for 3 seconds :
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "CRIMACK"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "OCIService"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "POSBAK"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "RETRIEVER"
@ping 127.0.0.1 -n 3 -w 1000 > nul

sc stop "OCI"
@ping 127.0.0.1 -n 3 -w 1000 > nul


sc start "BATCH"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "CRIMACK"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "OCIService"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "POSBAK"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "RETRIEVER"
@ping 127.0.0.1 -n 3 -w 1000 > nul
sc start "OCI"
@ping 127.0.0.1 -n 3 -w 1000 > nul

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