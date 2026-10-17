trigger Preventaccount on Account (before delete) {
    if(trigger.isbefore && trigger.isdelete){
        for(account acc :trigger.old){
           list<case> lcs = [SELECT AccountId, Origin, Priority
 FROM Case
 WHERE AccountId = :acc.Id];

            if(lcs.size()>0){
                acc.adderror('you cant delete this account because its having cases');
            }
        }
    }

}