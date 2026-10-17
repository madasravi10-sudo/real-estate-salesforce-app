trigger emailCheckOnLeadCreation on Lead (before insert,after update) {
    if(trigger.isbefore && trigger.isinsert && trigger.isafter && trigger.isupdate){
        set <id> ldids =new set<id>();
        for(lead ldrecnew:trigger.new){
            lead ldrecold =trigger.oldmap.get(ldrecnew.id);
            if(ldrecnew.Email !=ldrecold.Email){
               ldids.add(ldrecnew.id);
                return;
            }
            
        }
    }

}