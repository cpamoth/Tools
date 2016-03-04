rem TaxCredit Script for QA.
rem Created on 9/24/2013 by aclark


@echo off

setlocal

if TaxMMB=="" goto EOF
SET /p TaxMMB=Enter Whole Build Number:
SET userName=%1%
SET password=%2%


GreenText "****************************************************************"
GreenText "*********                  QA                     **************"
GreenText "*********                  QA                     **************"
GreenText "*********            RUNNING QA SCRIPT            **************"
GreenText "*********                  QA                     **************"
GreenText "*********                                         **************"
GreenText "*********                                         **************"
GreenText "****************************************************************"
echo.
echo.
echo.  

echo Processing Rollback Script for QA environment.
echo Started at %time% by aclark
echo.
echo.

GreenText "********* ROLLING BACK **************"
GreenText "********* ROLLING BACK **************"
GreenText "********* ROLLING BACK **************"

 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_RollbackScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_RollbackScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_DataChanges_RollbackScript.log"
echo.


echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_RollbackScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_RollbackScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_ObjectChanges_RollbackScript.log"
echo. 


echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_RollbackScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_RollbackScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_SchemaChanges_RollbackScript.log"




GreenText "********* Going  Going  (ConsolidatedScript) **************"
GreenText "********* Going  Going  (ConsolidatedScript) **************"
GreenText "********* Going  Going  (ConsolidatedScript) **************"
GreenText "********* Going  Going  (ConsolidatedScript) **************"
GreenText "********* Going  Going  (ConsolidatedScript) **************"

echo. 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_SchemaChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_SchemaChanges_ConsolidatedScript.log"
echo. 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_ObjectChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_ObjectChanges_ConsolidatedScript.log"
echo. 

echo Running C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_ConsolidatedScript.sql...
echo.
sqlcmd -S HCSQADB1 -d TaxCredit -i "C:\temp\PackagedBuilds\TaxCredit\%TaxMMB%\ChangeScripts\%TaxMMB%_DataChanges_ConsolidatedScript.sql" -U sqldeploy -P pxFMpeg2 > "C:\temp\PackagedBuilds\TaxCredit\Log\%TaxMMB%_DataChanges_ConsolidatedScript.log"
echo.

echo Finished at %time%

explorer "C:\temp\PackagedBuilds\TaxCredit\Log"

:EOF
endlocal