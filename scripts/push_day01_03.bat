@echo off
cd /d "%~dp0.."
set LOG=scripts\push_day01_03_log.txt
echo === Push Days 1-3 === > %LOG%
git add . >> %LOG% 2>&1
git commit -m "D01-D03: Day 1 evidence, Day 2 tour + grounding lab + stack map, Day 3 data model, permission set, restricted-user test, 56 sample records" -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" -m "Claude-Session: https://claude.ai/code/session_0192yzRMnSZHDyfoWp4xCgfr" >> %LOG% 2>&1
git push origin main >> %LOG% 2>&1
echo PUSH EXIT %ERRORLEVEL% >> %LOG%
git log --oneline -3 >> %LOG% 2>&1
