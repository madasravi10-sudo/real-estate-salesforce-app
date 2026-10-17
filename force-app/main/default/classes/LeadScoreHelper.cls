public class LeadScoreHelper {
    public static void CaluclateScore(List<Lead_Extended__c> leads){
        for (Lead_Extended__c lead :leads){
            integer score =0;
             if(lead.Email__c != null && lead.Email__c != '')
                score += 5;
             if(lead.Phone__c != null && lead.Phone__c != '')
                score += 5;
             if(lead.Company__c != null && lead.Company__c != '')
                score += 10;
              lead.Score__c = score;
            if(score > 15){
                lead.Status__c = 'Qualified';
        }
    }
}
}