public with sharing class BulkContactController {

    @AuraEnabled
    public static void createContacts(List<Contact> contactsList) {
        if (contactsList != null && !contactsList.isEmpty()) {
            insert contactsList;
        }
    }
}