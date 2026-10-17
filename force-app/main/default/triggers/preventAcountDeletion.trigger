trigger preventAcountDeletion on Account (before delete) {
    if(trigger.isbefore && trigger.isdelete)
    {
        for(account acc:trigger.old){
            if(acc.Active__c=='yes'){
                acc.adderror('you cant delete this account because its active account');
            }
        }
    }

}