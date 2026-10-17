public class LeaseAgreementTriggerHandler {
    public static void createLeaseTasks(List<Lease_Agreement__c> newLeases) {
        List<Task> tasksToInsert = new List<Task>();
        
        for(Lease_Agreement__c lease : newLeases) {
            Task t = new Task();
            t.Subject = 'Generate Lease Agreement Documents';
            t.Description = 'Property has been assigned to a tenant. Please generate and sign the formal lease agreement.';
            t.Priority = 'High';
            t.Status = 'Not Started';
            t.WhatId = lease.Id; // Links the task directly to the Lease Agreement record
            t.ActivityDate = Date.today().addDays(3); // Due date in 3 days
            tasksToInsert.add(t);
        }
        
        if(!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }
}