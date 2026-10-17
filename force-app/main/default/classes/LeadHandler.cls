public class LeadHandler {

    public static void afterUpdate(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {

        // 1. Get Converted Lead Status (Dynamic – Best Practice)
        LeadStatus convertedStatus = [
            SELECT MasterLabel
            FROM LeadStatus
            WHERE IsConverted = true
            LIMIT 1
        ];

        // 2. Prepare list for bulk conversion
        List<Database.LeadConvert> leadsToConvert =
            new List<Database.LeadConvert>();

        // 3. Loop through updated leads
        for (Lead newLd : newLeads) {

            Lead oldLd = oldLeadMap.get(newLd.Id);

            // 4. Check status change & not already converted
            if (newLd.Status == 'Closed - Converted'
                && oldLd.Status != 'Closed - Converted'
                && newLd.IsConverted == false) {

                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(newLd.Id);
                lc.setConvertedStatus(convertedStatus.MasterLabel);
                lc.setSendNotificationEmail(true);

                // Optional: control Opportunity creation
                lc.setDoNotCreateOpportunity(false);

                leadsToConvert.add(lc);
            }
        }

        // 5. Convert leads in bulk
        if (!leadsToConvert.isEmpty()) {
            Database.convertLead(leadsToConvert);
        }
    }
}