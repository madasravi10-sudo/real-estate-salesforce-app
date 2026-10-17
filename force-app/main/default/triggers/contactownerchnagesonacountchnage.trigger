trigger contactownerchnagesonacountchnage on Account (after update) {
    if(trigger.isafter && trigger.isupdate){
        set<id> accountids = new set<id>();
        for(account accrecnew :trigger.new){
            account accrecold =trigger.oldmap.get(accrecnew.id);
            if(accrecnew.OwnerId !=accrecold.OwnerId){
                accountids.add(accrecnew.id);
                if(accountids.isempty()){
                    return;
                }
                list<contact> lstcons=[select id,name,accountId ,OwnerId from contact where accountID IN:accountids];
                for(contact con:lstcons){
                account acc =trigger.newmap.get(con.accountId);
                    con.OwnerId=acc.OwnerId;
                    lstcons.add(con);
                    if(!lstcons.isempty()){
                        update lstcons;
                    }
                
            }
        }
    }
    }
}