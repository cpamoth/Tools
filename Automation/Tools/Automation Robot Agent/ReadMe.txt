
*******************************************
******************* WIP *******************
*******************************************



Code version	: ???
Last Modified	:

The tool AT.App.QAAutomationRobot.exe can work in four modes

1. Agent
2. Scheduler
3. DeploymentUpdate
4. ScheduleOnDemand


========================================================================================================
1. Agent
========================================================================================================
Summary:
--------


--------------------------------------------------------------------------------------------------------
Switch 				| Description
--------------------------------------------------------------------------------------------------------
--Mode 				| The argument for this switch should be "Agent"
				|
--------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
Syntax						| Purpose
--------------------------------------------------------------------------------------------------------
AT.App.QAAutomationRobot.exe --Mode Agent	| To start the tool in Agent mode
						|
--------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------
Examples			| Purpose
--------------------------------------------------------------------------------------------------------
				|
				|
				|
				|
--------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------
Batch Files			| Purpose
--------------------------------------------------------------------------------------------------------
				|
				|
				|
				|
--------------------------------------------------------------------------------------------------------



========================================================================================================
2. Scheduler
========================================================================================================
Summary:
--------


Arguments:
----------

Syntax:
-------

Examples:
---------


Batch Files available:
----------------------


========================================================================================================
3. DeploymentUpdate
========================================================================================================
Summary:
--------
This mode works Consists of 2 batch files to help notify Automation scheduler when there is a deployment 
going on and then have them proceed when that environment is back up.


Arguments:
----------

Syntax:
-------
NotifyDeploymentStart.bat <EnvironmentName>
NotifyDeploymentFinish.bat <EnvironmentName>

Examples:
---------
NotifyDeploymentStart.bat AutomationHR
NotifyDeploymentFinish.bat AutomationHR


Batch Files available:
----------------------
NotifyDeploymentStart.bat 	This batch file you will call when you are making your deployments to a 
				Pangea environment (you will pass the environment name as an argument)

NotifyDeploymentFinish.bat 	You will need to call this batch file when you finish that above 
				deployment (pass same environment name)

========================================================================================================
4. ScheduleOnDemand
========================================================================================================
Summary:
--------
This batch file runs an Automation smoke test for given environment.  A set of test cases have already 
been setup for this smoke test.


Arguments:
----------

Syntax:
-------

Examples:
---------


Batch Files available:
----------------------
RunSmokeTest.bat <EnvironmentName>