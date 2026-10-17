@isTest
public class LeaseAgreementTriggerTest {
    @isTest
    static void testTaskCreationOnLease() {
        // Create Test Property & Tenant (Using standard Name field)
        Property__c prop = new Property__c(Name = 'Sunset Apartment', Status__c = 'Available');
        insert prop;
        
        Tenant__c tenant = new Tenant__c(Name = 'John Doe', Phone_Number__c = '9876543212', Email__c = 'john@example.com');
        insert tenant;
        
        Test.startTest();
        // Insert Lease Agreement - should trigger task creation
        Lease_Agreement__c lease = new Lease_Agreement__c(
            Property__c = prop.Id,
            Tenant__c = tenant.Id,
            Agreed_Monthly_Rent__c = 1500,
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addYears(1)
        );
        insert lease;
        Test.stopTest();
        
        // Verify Task creation
        List<Task> createdTasks = [SELECT Id, Subject, WhatId FROM Task WHERE WhatId = :lease.Id];
        System.assertEquals(1, createdTasks.size(), 'A follow-up task should be automatically created for the lease agreement.');
    }
}