/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : accountocntactcontroller
 * Author          : <YourName>
 * Created Date    : Jan 15, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Jan 15, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Jan 15, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public with sharing class AccountContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId){
        return [
            SELECT Id, FirstName, LastName, Email, Phone
            FROM Contact
            WHERE AccountId = :accountId
            ORDER BY CreatedDate DESC
        ];
    }
}