public class PropertyTriggerHandler {
    public static void validatePropertyImages(List<Property__c> newProperties) {
        Set<Id> propIds = new Set<Id>();
        for(Property__c p : newProperties) {
            propIds.add(p.Id);
        }
        
        Set<Id> propertiesWithFiles = new Set<Id>();
        for(ContentDocumentLink cdl : [SELECT LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN :propIds]) {
            propertiesWithFiles.add(cdl.LinkedEntityId);
        }
        
        for(Property__c p : newProperties) {
            if(p.Id != null && !propertiesWithFiles.contains(p.Id)) {
                p.addError('Error: Property image is mandatory. Please upload an image before creating the property.');
            }
        }
    }
}