trigger LeadTrigger on Lead (after insert) {

    List<Messaging.SingleEmailMessage> emails =
        new List<Messaging.SingleEmailMessage>();

    for (Lead ld : Trigger.new) {

        Messaging.SingleEmailMessage eml =
            new Messaging.SingleEmailMessage();

        eml.setToAddresses(
            new List<String>{ UserInfo.getUserEmail() }
        );

        eml.setSubject('Lead was created, please check');

        eml.setPlainTextBody(
            'Lead created successfully. Lead Id: ' + ld.Id
        );

        emails.add(eml);
    }

    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
    }
}