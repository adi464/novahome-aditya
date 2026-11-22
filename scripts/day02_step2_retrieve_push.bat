@echo off
cd /d "%~dp0.."
set LOG=scripts\day02_retrieve_log.txt
echo === Day 2 step 2: retrieve + push === > %LOG%
call sf data query --query "SELECT Id, Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
call sf project retrieve start --manifest manifest\package.xml --target-org novahome-official >> %LOG% 2>&1
echo RETRIEVE EXIT %ERRORLEVEL% >> %LOG%
git add . >> %LOG% 2>&1
git commit -m "D02: retrieved metadata from NovaHome Official" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" -m "Claude-Session: https://claude.ai/code/session_0192yzRMnSZHDyfoWp4xCgfr" >> %LOG% 2>&1
git push origin main >> %LOG% 2>&1
echo PUSH EXIT %ERRORLEVEL% >> %LOG%
type %LOG%
pause
