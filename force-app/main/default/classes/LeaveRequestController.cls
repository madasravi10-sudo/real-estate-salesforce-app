public with sharing class LeaveRequestController {

    @AuraEnabled(cacheable=true)
    public static List<Leave_Requests__c> getMyLeaves() {
        try {
            List<Leave_Requests__c> myLeaves = [
                SELECT Id,
                       Name,
                       From_Date__c,
                       To_Date__c,
                       Reason__c,
                       Status__c,
                       Manager_Comment__c
                FROM Leave_Requests__c
                WHERE User__c = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC
            ];

            return myLeaves;

        } catch (Exception e) {
            throw new AuraHandledException(
                'Error retrieving leave requests: ' + e.getMessage()
            );
        }
    }


    @AuraEnabled(cacheable=true)
    public static List<Leave_Requests__c> getLeaveRequests() {
        try {
            List<Leave_Requests__c> myLeaves = [
                SELECT Id,
                       Name,
                       From_Date__c,
                       To_Date__c,
                       Reason__c,
                       Status__c,
                       User__c,
                       User__r.ManagerId,
                       Manager_Comment__c
                FROM Leave_Requests__c
                WHERE User__r.ManagerId = :UserInfo.getUserId()
                ORDER BY CreatedDate DESC
            ];

            return myLeaves;

        } catch (Exception e) {
            throw new AuraHandledException(
                'Error retrieving leave requests: ' + e.getMessage()
            );
        }
    }
}