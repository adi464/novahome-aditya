@echo off
cd /d "%~dp0.."
call sf org open --target-org novahome-official --browser chrome --path lightning/n/standard-AgentforceStudio > scripts\open_log.txt 2>&1
