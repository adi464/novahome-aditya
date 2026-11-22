@echo off
cd /d "%~dp0.."
set LOG=scripts\day01_permsets_log.txt
echo === Day 1: assign Data Cloud Admin + Prompt Template Manager === > %LOG%
call sf data query --query "SELECT Name FROM Organization" --target-org novahome-official >> %LOG% 2>&1
call sf data query --query "SELECT Name, Label FROM PermissionSet WHERE Label IN ('Data Cloud Admin','Prompt Template Manager')" --target-org novahome-official >> %LOG% 2>&1
call sf org assign permset --name CDPAdmin --target-org novahome-official >> %LOG% 2>&1
echo ASSIGN EXIT %ERRORLEVEL% >> %LOG%
call sf data query --query "SELECT PermissionSet.Label, Assignee.Username FROM PermissionSetAssignment WHERE Assignee.Username = 'adityanovahome.80590d994f22@agentforce.com' AND PermissionSet.IsOwnedByProfile = false" --target-org novahome-official >> %LOG% 2>&1
echo DONE >> %LOG%
