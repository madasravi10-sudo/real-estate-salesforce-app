trigger AccountTrigger2 on Account (after update) {

    if (Trigger.isAfter && Trigger.isUpdate) {

        Set<Id> accountIds = new Set<Id>();

        for (Account accRecNew : Trigger.new) {
            Account accRecOld = Trigger.oldMap.get(accRecNew.Id);

            if (
                accRecNew.BillingStreet  != accRecOld.BillingStreet ||
                accRecNew.BillingCity    != accRecOld.BillingCity ||
                accRecNew.BillingState   != accRecOld.BillingState ||
                accRecNew.BillingCountry != accRecOld.BillingCountry
            ) {
                accountIds.add(accRecNew.Id);
            }
        }

        if (accountIds.isEmpty()) {
            return;
        }

        List<Contact> lstCons = [
            SELECT Id, AccountId,
                   MailingStreet, MailingCity,
                   MailingState, MailingCountry
            FROM Contact
            WHERE AccountId IN :accountIds
        ];

        for (Contact con : lstCons) {
            Account acc = Trigger.newMap.get(con.AccountId);

            con.MailingStreet  = acc.BillingStreet;
            con.MailingCity    = acc.BillingCity;
            con.MailingState   = acc.BillingState;
            con.MailingCountry = acc.BillingCountry;
        }

        if (!lstCons.isEmpty()) {
            update lstCons;
        }
    }
}