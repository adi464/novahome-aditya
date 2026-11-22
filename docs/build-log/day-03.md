# Day 3 - NovaHome data model, security and sample data (NovaHome Official)

Date: Sun 22 Nov 2026 (workbook day: Sun 22 Nov)
Deploy: `sf project deploy start --manifest manifest/day02-03-deploy.xml` -> Succeeded

## Objects
| Object | Key fields | Relationships |
|---|---|---|
| Warranty__c (WR-0000) | Product_Category__c, Serial_Number__c (unique ext ID), Start/End_Date__c, Status__c, Days_Remaining__c | Master-Detail Account; lookups Contact, Order, Product2 |
| Loyalty_Member__c (LM-0000) | Tier__c, Points_Balance__c, Member_Since__c, Active__c | Lookup Contact |
| Shipment__c (SH-0000) | Carrier__c, Tracking_Number__c, Status__c, dates | Lookup Order |
Validation rules: End_After_Start, Points_Not_Negative, Contact_Required, Delivered_Needs_Date, Order_Required. Tabs, All list views, layouts. ERD: evidence/day-03/02_erd.png

## Security
- Permission set NovaHome_Agent_Access (read-only on Account, Contact, Order, Product2 + 3 custom objects; FLS read) assigned.
- Restricted-user test NovaHomeAccessTest: **Passed, 100%** (run 707gL00001dt6qo) - evidence/day-03/03_restricted_user_test.txt

## Sample data (synthetic)
`sf data import tree --plan data/day03/novahome-plan.json` -> 56 records: 8 Accounts, 8 Contacts, 6 Products, 8 Orders, 8 Loyalty Members, 10 Warranties, 8 Shipments (evidence/day-03/04_import_results.txt, 01_warranty_list.jpg)
