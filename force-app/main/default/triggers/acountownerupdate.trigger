trigger acountownerupdate on Account (after update) {
    if(trigger.isafter && trigger.isupdate){
        set<id> accountIds = new set<id>();
        for(account accrecnew:trigger.new){
            account accrecold=trigger.oldmap.get(accrecnew.id);
            if(accrecold.OwnerId != accrecnew.OwnerId){
                accountIds.add(accrecnew.id);
                }
            list <contact> lstconstoupdate=[select id,name,OwnerId,accountId from contact where accountId IN: accountIds];
            list<contact> lstcons=new list<contact>();
            for(contact con:lstcons){
                account acc=trigger.newmap.get(accrecnew.id);
                con.OwnerId=acc.OwnerId;
                lstconstoupdate.add(con);
                }
            if(lstconstoupdate.isempty()){
                update lstconstoupdate;
            }
           
            
        }
    }

}