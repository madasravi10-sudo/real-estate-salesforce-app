trigger updateAccountAnnualRevenue2 on Opportunity (after update) {
    if(trigger.isafter && trigger.isupdate){
        set<id> oppids=new set<id> ();
        for(opportunity opp:trigger.new){
            if(opp.accountid!=null){
                oppids.add(opp.accountid);
            }
              
        }
    }

}