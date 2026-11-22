@echo off
cd /d "%~dp0.."
set LOG=scripts\day02_log.txt
echo === Day 2: login, retrieve, push (NovaHome Official) === > %LOG%
echo.
echo STEP 1 of 3: A browser window will open. Log in to NovaHome Official if asked, then click ALLOW.
echo.
call sf org login web --alias novahome-official --instance-url https://orgfarm-d2b533db15-dev-ed.develop.my.salesforce.com --set-default >> %LOG% 2>&1
echo LOGIN EXIT %ERRORLEVEL% >> %LOG%
call sf data query --query "SELECT Id, Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
echo.
echo STEP 2 of 3: Retrieving metadata from the org...
call sf project retrieve start --manifest manifest\package.xml --target-org novahome-official >> %LOG% 2>&1
echo RETRIEVE EXIT %ERRORLEVEL% >> %LOG%
echo.
echo STEP 3 of 3: Pushing to GitHub adi464/novahome-aditya...
git init >> %LOG% 2>&1
git config user.name >nul 2>&1 || git config user.name "adi464"
git add . >> %LOG% 2>&1
git commit -m "D02: SFDX project + retrieved metadata (NovaHome Official)" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" -m "Claude-Session: https://claude.ai/code/session_0192yzRMnSZHDyfoWp4xCgfr" >> %LOG% 2>&1
git branch -M main >> %LOG% 2>&1
git remote get-url origin >nul 2>&1 || git remote add origin https://github.com/adi464/novahome-aditya.git
git push -u origin main >> %LOG% 2>&1
echo PUSH EXIT %ERRORLEVEL% >> %LOG%
echo.
echo Done. Results are in scripts\day02_log.txt
type %LOG%
pause
