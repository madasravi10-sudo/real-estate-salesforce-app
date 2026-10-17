public with sharing class LeaseController {
    @AuraEnabled
    public static void sendEmailWithPDF(Id recordId, String tenantEmail, String base64Pdf, String fileName) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{tenantEmail});
        mail.setSubject('Your Lease Agreement Document');
        mail.setPlainTextBody('Hello, \n\nPlease find attached your signed lease agreement document.\n\nThank you!');
        
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        efa.setFileName(fileName);
        efa.setBody(EncodingUtil.base64Decode(base64Pdf));
        mail.setFileAttachments(new List<Messaging.EmailFileAttachment>{efa});
        
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail});
    }
}