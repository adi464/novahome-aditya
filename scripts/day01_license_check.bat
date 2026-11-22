@echo off
cd /d "%~dp0.."
set LOG=scripts\day01_license_log.txt
echo === Data Cloud license check === > %LOG%
call sf data query --query "SELECT MasterLabel, DeveloperName, TotalLicenses, UsedLicenses FROM PermissionSetLicense WHERE MasterLabel LIKE '%%Data%%' OR MasterLabel LIKE '%%CDP%%' OR MasterLabel LIKE '%%Customer Data%%'" --target-org novahome-official >> %LOG% 2>&1
call sf data query --query "SELECT Name, Label, License.Name, PermissionSetGroupId FROM PermissionSet WHERE Label IN ('Data Cloud Admin','Data Cloud Architect')" --target-org novahome-official >> %LOG% 2>&1
echo DONE >> %LOG%
