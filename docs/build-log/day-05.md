# Day 5 - Integration basics (NovaHome Official)

Date: Tue 24 Nov 2026 (workbook day: Tue 24 Nov)
Script: scripts/day05_callout.bat (log: scripts/day05_log.txt)

| Component | API name | Settings |
|---|---|---|
| External Credential | NovaHome_Mock_API | Protocol Custom, principal DefaultGroup (API is public, no secrets) |
| Named Credential | NovaHome_Mock_API | Secured Endpoint, https://jsonplaceholder.typicode.com, linked to the External Credential |
| Permission Set | NovaHome_Integration_Access | External Credential Principal Access NovaHome_Mock_API-DefaultGroup; assigned |
| Anonymous Apex | scripts/apex/day05_callout.apex | GET callout:NovaHome_Mock_API/users/1, parse JSON, print one record |

## Result (Done when: callout returns data)
1. Deploy credentials: Succeeded.
2. Run 1, before principal access: `System.CalloutException: We couldn't access the credential(s)` (evidence/day-05/run1_before_access.txt)
3. Deploy + assign NovaHome_Integration_Access: Succeeded.
4. Run 2: `DAY5 STATUS: 200 OK` / `DAY5 RECORD: id=1 | name=Leanne Graham | email=Sincere@april.biz | city=Gwenborough` (run2_after_access.txt)
Setup screenshots: 01_named_credentials.jpg, 02_external_credential.jpg

## Concepts
- Outbound: Named Credential (where) + External Credential (how to authenticate) + principal access via permission set (who may).
- Inbound: External Client App (successor to Connected App) with an OAuth flow (client credentials, authorization code, JWT bearer).
- Credentials, manifest and Apex were reused from the practice build (commit 970b1e7) and deployed with the CLI.
