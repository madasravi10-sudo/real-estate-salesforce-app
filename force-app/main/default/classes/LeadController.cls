public with sharing class LeadController {

    @AuraEnabled(cacheable=true)
    public static List<Lead_Extended__c> getLeads(){
        return [
            SELECT Id, Name, Email__c, Phone__c, Company__c, Score__c, Status__c
            FROM Lead_Extended__c
            ORDER BY CreatedDate DESC
        ];
    }
}