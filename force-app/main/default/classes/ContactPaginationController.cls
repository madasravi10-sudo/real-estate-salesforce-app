public with sharing class ContactPaginationController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Integer pageSize, Integer offsetVal) {
        return [
            SELECT Id, FirstName, LastName, Email, Phone
            FROM Contact
            ORDER BY CreatedDate DESC
            LIMIT :pageSize
            OFFSET :offsetVal
        ];
    }
}