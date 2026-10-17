public class LeaseEmailNotifier implements Schedulable {
    public void execute(SchedulableContext sc) {
        Date target1Month = Date.today().addMonths(1);
        Date target1Day = Date.today().addDays(1);
        
        List<Lease_Agreement__c> leases = [
            SELECT Id, Tenant__r.Email__c, End_Date__c 
            FROM Lease_Agreement__c 
            WHERE End_Date__c = :target1Month OR End_Date__c = :target1Day
        ];
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        for (Lease_Agreement__c l : leases) {
            if (l.Tenant__r.Email__c != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] { l.Tenant__r.Email__c });
                mail.setSubject('Lease Expiry Reminder');
                mail.setPlainTextBody('Your lease is ending on ' + l.End_Date__c + '. Please contact management.');
                emailList.add(mail);
            }
        }
        if (!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        }
    }
}