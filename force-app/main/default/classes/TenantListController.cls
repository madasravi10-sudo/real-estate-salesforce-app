public with sharing class TenantListController {
    @AuraEnabled(cacheable=true)
    public static List<Tenant__c> getTenants() {
        return [SELECT Id, Name, Phone_Number__c, Email__c, CreatedDate FROM Tenant__c ORDER BY CreatedDate DESC];
    }
}