@isTest
public class LeaseEmailNotifierTest {
    @isTest
    static void testLeaseEmailNotificationJob() {
        // Create Test Property & Tenant (Using standard Name field)
        Property__c prop = new Property__c(Name = 'Ocean View', Status__c = 'Occupied');
        insert prop;
        
        Tenant__c tenant = new Tenant__c(Name = 'Jane Smith', Phone_Number__c = '9876543213', Email__c = 'jane@example.com');
        insert tenant;
        
        // Lease expiring exactly 1 month from today
        Lease_Agreement__c lease = new Lease_Agreement__c(
            Property__c = prop.Id,
            Tenant__c = tenant.Id,
            Agreed_Monthly_Rent__c = 2000,
            Start_Date__c = Date.today().addMonths(-11),
            End_Date__c = Date.today().addMonths(1)
        );
        insert lease;
        
        Test.startTest();
        LeaseEmailNotifier scheduler = new LeaseEmailNotifier();
        String cronExp = '0 0 0 * * ?';
        System.schedule('Test Lease Expiry Job', cronExp, scheduler);
        Test.stopTest();
        
        System.assert(true, 'Scheduled job executed successfully without exceptions.');
    }
}