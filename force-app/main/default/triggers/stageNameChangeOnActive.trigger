trigger stageNameChangeOnActive on Account (after update) {
    if(trigger.isafter && trigger.isupdate){
        set<id> accountids = new set<id>();
        for(account accrecnew: trigger.new){
            account accrecold=trigger.oldmap.get(accrecnew.id);
            if(accrecnew.Active__c=='no'){
                accountids.add(accrecnew.id);
                if(accountids.isempty()){
                    return;
                }
                list<opportunity> lstopps=[select id,name ,accountid,StageName from opportunity where AccountId IN: accountids];
                for(opportunity opp:lstopps){
                    Account acc=trigger.newmap.get(opp.accountid);
                  opp.stageName='closed Lost';
                    }
                           if(!lstopps.isempty()){
                            update lstopps;
                        }
                    }
                
            }
        }
}