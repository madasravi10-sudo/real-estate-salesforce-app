trigger NoOfRecordsOnAccount on Account (after insert) {

    List<Account> accList = new List<Account>();

    for (Account acc : Trigger.new) {
        if (acc.NumberofLocations__c != null && acc.NumberofLocations__c > 0) {

            for (Integer i = 1; i <= acc.NumberofLocations__c; i++) {
                Account newAcc = new Account();
                newAcc.Name = acc.Name + ' - Location ' + i;
                newAcc.Phone = acc.Phone;
                accList.add(newAcc);
            }
        }
    }

    if (!accList.isEmpty()) {
        insert accList;
    }
}