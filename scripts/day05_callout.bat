@echo off
cd /d "%~dp0.."
set LOG=scripts\day05_log.txt
echo === Day 5: Named + External Credential callout (NovaHome Official) === > %LOG%
call sf data query --query "SELECT Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
echo --- deploy credentials --- >> %LOG%
call sf project deploy start --manifest manifest\day05-integration.xml --target-org novahome-official --wait 10 >> %LOG% 2>&1
echo DEPLOY1 EXIT %ERRORLEVEL% >> %LOG%
echo --- RUN 1: before principal access --- >> %LOG%
call sf apex run --file scripts\apex\day05_callout.apex --target-org novahome-official >> %LOG% 2>&1
echo RUN1 EXIT %ERRORLEVEL% >> %LOG%
echo --- deploy + assign permission set --- >> %LOG%
call sf project deploy start --metadata PermissionSet:NovaHome_Integration_Access --target-org novahome-official --wait 10 >> %LOG% 2>&1
echo DEPLOY2 EXIT %ERRORLEVEL% >> %LOG%
call sf org assign permset --name NovaHome_Integration_Access --target-org novahome-official >> %LOG% 2>&1
echo ASSIGN EXIT %ERRORLEVEL% >> %LOG%
echo --- RUN 2: after principal access --- >> %LOG%
call sf apex run --file scripts\apex\day05_callout.apex --target-org novahome-official >> %LOG% 2>&1
echo RUN2 EXIT %ERRORLEVEL% >> %LOG%
echo DONE >> %LOG%
