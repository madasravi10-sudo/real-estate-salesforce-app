trigger LeadExtendedTrigger1 on Lead_Extended__c (before insert, before update) {

    for(Lead_Extended__c leadRec : Trigger.new){

        // Score Assignment based on Source
        if(leadRec.Source__c == 'Referral'){
            leadRec.Score__c = 10;
        }
        else if(leadRec.Source__c == 'Web'){
            leadRec.Score__c = 5;
        }

        // Assign Queue for Hot Leads
        if(leadRec.Score__c != null && leadRec.Score__c >= 80){
            Group hotQueue = [SELECT Id FROM Group WHERE Name = 'Hot Lead Queue' LIMIT 1];
            leadRec.OwnerId = hotQueue.Id;
        }
    }
}