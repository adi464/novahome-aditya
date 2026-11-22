/**
 * Day 3 restricted-user test.
 * A user on the 'Minimum Access - Salesforce' profile must NOT see NovaHome data,
 * and must see it read-only once 'NovaHome Agent Access' is assigned.
 * Agents act as their running user, so this is exactly what an agent would get.
 */
@isTest
private class NovaHomeAccessTest {

    @testSetup
    static void setup() {
        Account a = new Account(Name = 'Test Household');
        insert a;
        Contact c = new Contact(LastName = 'Tester', AccountId = a.Id);
        insert c;
        Order o = new Order(AccountId = a.Id, EffectiveDate = Date.today(), Status = 'Draft');
        insert o;
        insert new Warranty__c(Account__c = a.Id, Contact__c = c.Id, Order__c = o.Id,
                               Product_Category__c = 'Furniture', Serial_Number__c = 'TEST-001',
                               Start_Date__c = Date.today(), End_Date__c = Date.today().addYears(2));
        insert new Loyalty_Member__c(Contact__c = c.Id, Tier__c = 'Gold', Points_Balance__c = 100);
        insert new Shipment__c(Order__c = o.Id, Tracking_Number__c = 'TEST-TRK-1', Status__c = 'Pending');
    }

    static User restrictedUser() {
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Minimum Access - Salesforce' LIMIT 1];
        String u = 'restricted' + DateTime.now().getTime() + '@novahome-test.example';
        User usr = new User(Alias = 'rstr', Email = u, Username = u, LastName = 'Restricted',
                            ProfileId = p.Id, TimeZoneSidKey = 'Asia/Kolkata', LocaleSidKey = 'en_IN',
                            EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US');
        insert usr;
        return usr;
    }

    @isTest
    static void withoutPermissionSet_seesNothing() {
        User usr = restrictedUser();
        System.runAs(usr) {
            System.assertEquals(false, Schema.sObjectType.Warranty__c.isAccessible(), 'Warranty should be hidden');
            System.assertEquals(false, Schema.sObjectType.Loyalty_Member__c.isAccessible(), 'Loyalty should be hidden');
            System.assertEquals(false, Schema.sObjectType.Shipment__c.isAccessible(), 'Shipment should be hidden');
            Boolean blocked = false;
            try {
                List<Warranty__c> rows = [SELECT Id FROM Warranty__c WITH USER_MODE];
            } catch (Exception e) {
                blocked = true;
            }
            System.assert(blocked, 'User-mode query must be blocked without the permission set');
        }
    }

    @isTest
    static void withPermissionSet_readOnly() {
        User usr = restrictedUser();
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'NovaHome_Agent_Access'];
        insert new PermissionSetAssignment(AssigneeId = usr.Id, PermissionSetId = ps.Id);
        System.runAs(usr) {
            System.assertEquals(true, Schema.sObjectType.Warranty__c.isAccessible(), 'Warranty readable');
            System.assertEquals(false, Schema.sObjectType.Warranty__c.isUpdateable(), 'Warranty must be read-only');
            System.assertEquals(false, Schema.sObjectType.Shipment__c.isCreateable(), 'Shipment must be read-only');
            System.assertEquals(true, Schema.sObjectType.Warranty__c.fields.End_Date__c.isAccessible(), 'FLS: End Date readable');
            List<Warranty__c> w = [SELECT Id, End_Date__c, Status__c FROM Warranty__c WITH USER_MODE];
            List<Loyalty_Member__c> l = [SELECT Id, Tier__c FROM Loyalty_Member__c WITH USER_MODE];
            List<Shipment__c> s = [SELECT Id, Status__c FROM Shipment__c WITH USER_MODE];
            System.assertEquals(1, w.size(), 'Sees the warranty');
            System.assertEquals(1, l.size(), 'Sees the loyalty member');
            System.assertEquals(1, s.size(), 'Sees the shipment');
        }
    }
}
