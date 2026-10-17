@isTest
public class AutoLeadConversionTest {

    @isTest
    static void testLeadAutoConversion() {

        // 1️⃣ Get Converted Lead Status dynamically
        LeadStatus convertedStatus = [
            SELECT MasterLabel
            FROM LeadStatus
            WHERE IsConverted = true
            LIMIT 1
        ];

        // 2️⃣ Create test leads
        List<Lead> leadList = new List<Lead>();

        for (Integer i = 1; i <= 5; i++) {
            Lead ld = new Lead(
                FirstName = 'Test',
                LastName  = 'Lead' + i,
                Company   = 'Test Company',
                Status    = 'Open - Not Contacted'
            );
            leadList.add(ld);
        }

        // 3️⃣ Insert leads
        insert leadList;

        Test.startTest();

        // 4️⃣ Update status to Converted
        for (Lead ld : leadList) {
            ld.Status = convertedStatus.MasterLabel;
        }
        update leadList;

        Test.stopTest();

        // 5️⃣ Assertions - verify conversion
        List<Lead> convertedLeads = [
            SELECT Id, IsConverted,
                   ConvertedAccountId,
                   ConvertedContactId
            FROM Lead
            WHERE Id IN :leadList
        ];

        for (Lead ld : convertedLeads) {
            System.assertEquals(
                true,
                ld.IsConverted,
                'Lead should be converted'
            );
            System.assertNotEquals(
                null,
                ld.ConvertedAccountId,
                'Account should be created'
            );
            System.assertNotEquals(
                null,
                ld.ConvertedContactId,
                'Contact should be created'
            );
        }
    }
}