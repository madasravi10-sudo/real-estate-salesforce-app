/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : EscalationController
 * Author          : <YourName>
 * Created Date    : May 15, 2026
 * Last Modified By: <YourName>
 * Last Modified On: May 15, 2026
 * Description     : This class fetches escalation cases
 *                   for Customer 360 highlight panel.
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  May 15, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public with sharing class EscalationController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getEscalationCases(Id accountId) {

        // Return empty list if accountId is null
        if(accountId == null) {
            return new List<Case>();
        }

        return [

            SELECT
                   Id,
                   CaseNumber,
                   Subject,
                   Status,
                   Priority,
                   Description,
                   Owner.Name,
                   Reason,
                   ClosedDate,
                   CreatedDate,
                   IsClosed

            FROM Case

            WHERE AccountId = :accountId

            AND Reason = 'Escalation'

            AND (
                    IsClosed = false
                    OR ClosedDate = LAST_N_DAYS:30
                )

            ORDER BY CreatedDate DESC

            LIMIT 5
        ];
    }
}