rem TaxCredit Master Upgrade Script for PRODUCTION
rem Created on 9/20/2013 by aclark


@echo off

setlocal

if TaxMMB=="" goto EOF
SET /p TaxMMB=Enter Whole Build Number:
SET userName=%1%
SET password=%2%


 
echo Started at %time% by aclark
echo.
echo. 


GreenText "****************** THIS IS FOR PRODUCTION ONLY *********************"
GreenText "****************************************************************"
GreenText "*********                                         **************"
GreenText "********* PRODUCTION SCRIPT ...  NO ROLLBACK SQL  **************"
GreenText "*********                                         **************"
GreenText "****************************************************************"
echo.
echo.
echo.
GreenText "********* RUNNING ConsolidatedScript **************"
GreenText "********* RUNNING ConsolidatedScript **************"
GreenText "********* RUNNING ConsolidatedScript **************"
GreenText "********* RUNNING ConsolidatedScript **************"
GreenText "********* RUNNING ConsolidatedScript **************"

echo. 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSDB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_SchemaChanges_ConsolidatedScript.log"
echo. 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSDB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_ObjectChanges_ConsolidatedScript.log"
echo. 


echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSDB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_DataChanges_ConsolidatedScript.log"
echo.

echo Finished at %time%

explorer "C:\temp\PackagedBuilds\TaxCredit\Log"

:EOF
endlocal