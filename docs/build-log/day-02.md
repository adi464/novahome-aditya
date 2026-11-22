# Day 2 - Dev tools, org tour and first grounded prompt (NovaHome Official)

Date: Sun 22 Nov 2026 (workbook day: Sat 21 Nov)

## 1. Project + repo
- `sf org login web --alias novahome-official` (first two attempts timed out: browser autofilled the practice username; fixed by logging in with the official username)
- SFDX project, `sf project retrieve start --manifest manifest/package.xml` -> 187 files, pushed to github.com/adi464/novahome-aditya

## 2. Org tour (evidence/day-02)
| # | Page | Where |
|---|---|---|
| 01 | Agentforce Agents | Agentforce Studio > Agents (NovaHome Employee Agent; GPT-4.1 retirement banner) |
| 02 | Data Cloud Setup | Setup > Data Cloud Setup Home (instance live, 1 data space, 2 connections) |
| 03 | Prompt Builder | Setup > Prompt Builder (20+ templates) |
| 04 | Trust Layer - Data Masking | Setup > Einstein Trust Layer (LLM data masking off by default) |
| 05 | Trust Layer - Safety & Security | same page (toxicity in responses always on; prompts = beta toggle) |
| 06 | AI Models | Agentforce Studio > AI Models > Generate (GPT 4.1 ... 5.4) |

## 3. Grounding lab (Flex, GPT 5 Mini)
| | Template | Result |
|--|--|--|
| A | NovaHome_Warranty_Ungrounded | "I do not know NovaHome's specific warranty policy without more information..." - no facts. 2.17 s, 468 tokens |
| B | NovaHome_Warranty_Grounded | All policy facts: 2y furniture, 3y large / 1y small appliances, +1y Gold, 30-day claim, repair then replace, exclusions. 2.59 s, 661 tokens |

Lesson: same model, same question; only the context changed. Ungrounded, the model either refuses (today) or invents a generic policy (practice org, 19 Nov). Grounded, it answers with NovaHome's exact terms.

## 4. 4-layer stack map
evidence/day-02/09_stack_map.png - engagement (AIforce/Slack), agency (Agentforce), work (Customer 360), context (Data 360), on the Trust Layer + models.
