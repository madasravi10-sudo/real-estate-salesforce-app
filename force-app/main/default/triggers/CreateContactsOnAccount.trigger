trigger CreateContactsOnAccount on Account (after insert) {

    List<Contact> conList = new List<Contact>();

    for (Account acc : Trigger.new) {
        if (acc.Number_of_Contacts__c != null && acc.Number_of_Contacts__c > 0) {

            for (Integer i = 1; i <= acc.Number_of_Contacts__c; i++) {
                Contact con = new Contact();
                con.LastName = 'Contact ' + i;
                con.AccountId = acc.Id;
                conList.add(con);
            }
        }
    }

    if (!conList.isEmpty()) {
        insert conList;
    }
}