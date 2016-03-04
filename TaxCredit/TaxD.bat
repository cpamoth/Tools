@echo off
setlocal

if TaxMMB=="" goto EOF
SET /p TaxMMB=Enter Last 3 Build Number:


REM  Delete TaxCreditWebLayer folder if exist
IF Exist C:\Users\%username%\Desktop\Tax_Credit_QA_Promote rd /s/q C:\Users\%username%\Desktop\Tax_Credit_QA_Promote
echo.
echo.
 

set SVNWebLayer=http://hcsprodbugtrack1.geninfo.com:81/svn/TaxCredit/Builds/TaxCredit_2.3/2.3.%TaxMMB%/WebLayer/
set SVNConfigWeb3=http://hcsprodbugtrack1.geninfo.com:81/svn/TaxCredit/Builds/TaxCredit_2.3/2.3.%TaxMMB%/Configs/QA/HCSQANWWEB3/
set SVNConfigWeb4=http://hcsprodbugtrack1.geninfo.com:81/svn/TaxCredit/Builds/TaxCredit_2.3/2.3.%TaxMMB%/Configs/QA/HCSQANWWEB4/

set LocalComputerWebLayer3=C:\Users\%username%\Desktop\Tax_Credit_QA_Promote\HCSQANWWEB3
set LocalComputerWebLayer4=C:\Users\%username%\Desktop\Tax_Credit_QA_Promote\HCSQANWWEB4
set LocalComputerConfig3=C:\Users\%username%\Desktop\Tax_Credit_QA_Promote\3_HCSQANWWEB3_Config
set LocalComputerConfig4=C:\Users\%username%\Desktop\Tax_Credit_QA_Promote\4_HCSQANWWEB4_Config

 
echo.
echo.
echo.
GreenText "Download TaxCreditWebLayer file from SVN to your local desktop..."
echo.
echo.
svn export %SVNWebLayer% %LocalComputerWebLayer3%
echo.
echo.
GreenText "HCSQANWWEB4 folder is being create.....  Copying everything from HCSQANWWEB3 into HCSQANWWEB4"
echo.
echo.
Robocopy %LocalComputerWebLayer3% %LocalComputerWebLayer4%  /e 
echo.
echo.
GreenText "Downloading HCSQANWWEB3 TaxCredit Configs file from SVN to your local desktop..."
echo.
echo.
svn export %SVNConfigWeb3% %LocalComputerConfig3%
echo.
echo.
GreenText "Transfering everything from 3_HCSQANWWEB3_Config into HCSQANWWEB3 folder."
robocopy %LocalComputerConfig3% %LocalComputerWebLayer3% /e
echo.
echo.
GreenText "Downloading HCSQANWWEB4 TaxCredit Configs file from SVN to your local desktop..."
echo.
echo.
svn export %SVNConfigWeb4% %LocalComputerConfig4%
echo.
echo.
GreenText "Transfering everything from 4_HCSQANWWEB4_Config into HCSQANWWEB4 folder."
echo.
echo.
robocopy %LocalComputerConfig4% %LocalComputerWebLayer4% /e
echo.
echo.
GreenText "Deleting 3_HCSQANWWEB3_Config and 4_HCSQANWWEB4_Config from ...\Desktop\Tax_Credit_QA_Promote folder"
echo.
echo.
rd /s/q %LocalComputerConfig3%
rd /s/q %LocalComputerConfig4%
echo.
echo.
echo.
::RedText "Job is done..."
explorer "C:\Users\%username%\Desktop\Tax_Credit_QA_Promote"
echo.
echo.
echo.
::YellowText "Please completed the following step below...."
::echo.
::YellowText "     1. Stop the App_Pool for Tax on HCSQANWWEB3 and HCSQANWWEB4 server."
::echo.
::YellowText "     2. Delete the contents of the Tax physical path [E:\WebRoot\Tax] on both server HCSQANWWEB3 and HCSQANWWEB4"
::echo.
::YellowText "     3. File Transfer the WebLayer and config on HCSQANWWEB3"
::echo.
::YellowText "     4. File Transfer the WebLayer and config on HCSQANWWEB4"
::echo.
::YellowText "     5. Start the App_Pool"
echo.
echo.
echo.
echo.
echo.


:: After running the exit command will close the window
exit



:EOF
endlocal
