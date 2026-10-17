@isTest
public class MaintenanceRequestHandlerTest {
    @isTest
    static void testVendorAutoAssignment() {
        // Create Test Vendors (Using standard Name field)
        Vendor__c v1 = new Vendor__c(Name = 'Vendor A', Phone_Number__c = '9876543210', Email__c = 'a@vendor.com');
        Vendor__c v2 = new Vendor__c(Name = 'Vendor B', Phone_Number__c = '9876543211', Email__c = 'b@vendor.com');
        insert new List<Vendor__c>{v1, v2};
        
        // Create Test Property (Using standard Name field instead of Property_Name__c)
        Property__c prop = new Property__c(Name = 'Green Villa', Status__c = 'Available');
        insert prop;
        
        Test.startTest();
        // Insert Maintenance Request - should automatically assign to a vendor with least workload
        Maintenance_Request__c req = new Maintenance_Request__c(
            Property__c = prop.Id,
            Status__c = 'Open',
            Description__c = 'Plumbing issue'
        );
        insert req;
        Test.stopTest();
        
        // Verify assignment
        Maintenance_Request__c insertedReq = [SELECT Id, Vendor__c FROM Maintenance_Request__c WHERE Id = :req.Id];
        System.assertNotEquals(null, insertedReq.Vendor__c, 'Vendor should be automatically assigned.');
    }
}