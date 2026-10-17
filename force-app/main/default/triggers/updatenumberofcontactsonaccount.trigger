trigger updatenumberofcontactsonaccount on Contact (before insert) {
    if(trigger.isbefore && trigger.isinsert){
        set<id> accountids=new set<id>();
        for(contact con:trigger.new){
            accountids.add(con.accountid);
            }
        list<account> lstaccs=[select id,(select id from contacts) from account where Id IN:accountids];
        for(account acc:lstaccs){
            acc.Number_of_Contacts__c=acc.contacts.size();
            update lstaccs;
        }
    }
}