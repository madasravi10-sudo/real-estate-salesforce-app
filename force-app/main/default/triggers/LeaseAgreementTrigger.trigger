trigger LeaseAgreementTrigger on Lease_Agreement__c (after insert) {
    if(Trigger.isInsert && Trigger.isAfter) {
        LeaseAgreementTriggerHandler.createLeaseTasks(Trigger.new);
    }
}