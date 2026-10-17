trigger accounttrigger4 on Account (after update) {
    if(trigger.isafter && trigger.isupdate){
        set<id> accountids =new set<id>();
        for(account accrecnew :trigger.new){
            account accoldrec=trigger.oldmap.get(accrecnew.Id);
            if(accrecnew.phone !=accoldrec.phone ||
               accrecnew.fax !=accoldrec.fax){
                 accountids.add(accrecnew.id);
               }
            if(accountids.isempty()){
                return;
            }
            list<contact> lstcons =[select id,accountId,phone,fax from contact where accountId IN: accountIds];
             List<Contact> contactsToUpdate = new List<Contact>();
                for(contact con :lstcons){
                    account acc = trigger.newmap.get(con.accountId);
                con.phone=acc.phone;
                con.fax=acc.fax;
                 contactsToUpdate.add(con); 
               }
            if(!contactsToUpdate.isempty()){
          update contactsToUpdate ;
            }
            
              }
    }
}