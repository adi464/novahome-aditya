@echo off
cd /d "%~dp0.."
set LOG=scripts\day02_login_log.txt
echo === Day 2 step 1: CLI login to NovaHome Official === > %LOG%
echo.
echo A browser tab will open. CHECK the address starts with orgfarm-d2b533db15
echo Log in as adityanovahome.80590d994f22@agentforce.com, then click ALLOW.
echo.
call sf org login web --alias novahome-official --instance-url https://orgfarm-d2b533db15-dev-ed.develop.my.salesforce.com --set-default >> %LOG% 2>&1
echo LOGIN EXIT %ERRORLEVEL% >> %LOG%
call sf data query --query "SELECT Id, Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
type %LOG%
pause
