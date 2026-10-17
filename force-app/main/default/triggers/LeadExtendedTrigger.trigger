trigger LeadExtendedTrigger on Lead_Extended__c (before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
        LeadScoreHelper.CaluclateScore(trigger.new);
    }
}
}