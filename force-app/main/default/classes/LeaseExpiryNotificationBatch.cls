public class LeaseExpiryNotificationBatch implements Database.Batchable<SObject>, Schedulable {
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date oneMonthFromToday = Date.today().addDays(30);
        Date oneDayFromToday = Date.today().addDays(1);
        
        // Query leases expiring in exactly 30 days or 1 day
        String query = 'SELECT Id, Name, End_Date__c, Tenant__r.Email__c, Tenant__r.Name FROM Lease_Agreement__c WHERE End_Date__c = :oneMonthFromToday OR End_Date__c = :oneDayFromToday';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Lease_Agreement__c> scope) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        Date today = Date.today();
        
        for(Lease_Agreement__c lease : scope) {
            if(lease.Tenant__r != null && lease.Tenant__r.Email__c != null) {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new List<String>{lease.Tenant__r.Email__c});
                
                String timeFrame = (lease.End_Date__c == today.addDays(1)) ? '1 day' : '1 month';
                mail.setSubject('URGENT: Lease Agreement Expiring in ' + timeFrame);
                mail.setPlainTextBody('Dear ' + lease.Tenant__r.Name + ',\n\nYour lease agreement for property is set to expire in ' + timeFrame + ' (' + lease.End_Date__c + '). Please contact management for renewal options.\n\nThank you.');
                
                emails.add(mail);
            }
        }
        
        if(!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
    
    public void finish(Database.BatchableContext bc) {}
    
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new LeaseExpiryNotificationBatch(), 50);
    }
}