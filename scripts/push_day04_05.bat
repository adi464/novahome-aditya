@echo off
cd /d "%~dp0.."
set LOG=scripts\push_day04_05_log.txt
echo === Retrieve agent + push Days 4-5 === > %LOG%
call sf project retrieve start --metadata AiAuthoringBundle:NovaHome_FAQ_Agent --metadata AiAuthoringBundle:NovaHome_Employee_Agent --target-org novahome-official >> %LOG% 2>&1
echo RETRIEVE EXIT %ERRORLEVEL% >> %LOG%
git add . >> %LOG% 2>&1
git commit -m "D04-D05: NovaHome FAQ Agent draft + 5-question log; Named/External Credential callout (fail then 200 OK)" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" -m "Claude-Session: https://claude.ai/code/session_0192yzRMnSZHDyfoWp4xCgfr" >> %LOG% 2>&1
git push origin main >> %LOG% 2>&1
echo PUSH EXIT %ERRORLEVEL% >> %LOG%
git log --oneline -2 >> %LOG% 2>&1
echo DONE >> %LOG%
