@echo off
cd /d "%~dp0.."
set LOG=scripts\day02_03_deploy_log.txt
echo === Deploy Day 2 prompts + Day 3 data model to NovaHome Official === > %LOG%
call sf data query --query "SELECT Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
call sf project deploy start --manifest manifest\day02-03-deploy.xml --target-org novahome-official --wait 20 >> %LOG% 2>&1
echo DEPLOY EXIT %ERRORLEVEL% >> %LOG%
call sf org assign permset --name NovaHome_Agent_Access --target-org novahome-official >> %LOG% 2>&1
echo ASSIGN EXIT %ERRORLEVEL% >> %LOG%
call sf apex run test --class-names NovaHomeAccessTest --result-format human --wait 10 --target-org novahome-official >> %LOG% 2>&1
echo TEST EXIT %ERRORLEVEL% >> %LOG%
call sf data import tree --plan data\day03\novahome-plan.json --target-org novahome-official >> %LOG% 2>&1
echo IMPORT EXIT %ERRORLEVEL% >> %LOG%
call sf data query --query "SELECT COUNT() FROM Warranty__c" --target-org novahome-official >> %LOG% 2>&1
echo DONE >> %LOG%
