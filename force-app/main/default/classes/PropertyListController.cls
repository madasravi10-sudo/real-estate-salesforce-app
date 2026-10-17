public with sharing class PropertyListController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getProperties(
        String availability, 
        String furnishing, 
        Decimal minPrice, 
        Decimal maxPrice, 
        Decimal userLat, 
        Decimal userLon, 
        Decimal distanceKm,
        Integer pageNumber, 
        Integer pageSize
    ) {
        Integer offset = (pageNumber - 1) * pageSize;
        
        String query = 'SELECT Id, Name, City__c, State__c, Rent__c, Status__c, Furnishing_Status__c, Location__latitude__s, Location__longitude__s FROM Property__c WHERE Id != NULL';
        
        if(availability != null && availability != '') {
            query += ' AND Status__c = :availability';
        }
        if(furnishing != null && furnishing != '') {
            query += ' AND Furnishing_Status__c = :furnishing';
        }
        if(minPrice != null) {
            query += ' AND Rent__c >= :minPrice';
        }
        if(maxPrice != null) {
            query += ' AND Rent__c <= :maxPrice';
        }
        // Nearby distance filter in KM
        if(userLat != null && userLon != null && distanceKm != null) {
            query += ' AND DISTANCE(Location__c, GEOLOCATE(:userLat, :userLon), \'km\') <= :distanceKm';
        }
        
        query += ' LIMIT :pageSize OFFSET :offset';
        
        List<Property__c> propList = Database.query(query);
        Integer totalRecords = [SELECT COUNT() FROM Property__c];
        
        Map<String, Object> response = new Map<String, Object>();
        response.put('properties', propList);
        response.put('totalRecords', totalRecords);
        return response;
    }
}