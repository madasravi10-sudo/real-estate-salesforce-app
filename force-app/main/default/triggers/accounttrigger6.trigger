trigger accounttrigger6 on Account (after insert,after update) {
    if(trigger.isafter && trigger.isinsert){
        list<contact> lstcons =new list<contact>();
        for(account acc:trigger.new){
            contact con =new contact();
            con.lastname=acc.name;
            con.firstname=acc.name;
            con.phone=acc.phone;
            con.accountid=acc.id;
            con.Additional_Master_Agence_Mails__c=acc.Additional_Master_Agence_Mails__c;
            lstcons.add(con);
            }
         if (lstCons.isEmpty()) {
        insert lstcons;
        }
    }
    
   if (Trigger.isAfter && Trigger.isUpdate) {

    Set<Id> accountIds = new Set<Id>();

    for (Account accNew : Trigger.new) {
        Account accOld = Trigger.oldMap.get(accNew.Id);

        if (accNew.Additional_Master_Agence_Mails__c
            != accOld.Additional_Master_Agence_Mails__c) {

            accountIds.add(accNew.Id);
        }
    }

    if (accountIds.isEmpty()) {
        return;
    }

    List<Contact> lstCons = [
        SELECT Id, AccountId, Additional_Master_Agence_Mails__c
        FROM Contact
        WHERE AccountId IN :accountIds
    ];

    for (Contact con : lstCons) {
        Account acc = Trigger.newMap.get(con.AccountId);
        con.Additional_Master_Agence_Mails__c =
            acc.Additional_Master_Agence_Mails__c;
    }

    if (!lstCons.isEmpty()) {
        update lstCons;
    }
}

            
}