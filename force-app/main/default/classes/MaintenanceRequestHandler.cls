public class MaintenanceRequestHandler {
    public static void assignVendor(List<Maintenance_Request__c> requests) {
        // Query vendors along with their active maintenance requests load
        List<Vendor__c> vendors = [
            SELECT Id, (SELECT Id FROM Maintenance_Requests__r WHERE Status__c != 'Completed' AND Status__c != 'Cancelled') 
            FROM Vendor__c
        ];
        
        if (vendors.isEmpty()) return;
        
        for (Maintenance_Request__c req : requests) {
            Vendor__c bestVendor = vendors[0];
            integer minLoad = bestVendor.Maintenance_Requests__r.size();
            
            for (Vendor__c v : vendors) {
                integer currentLoad = v.Maintenance_Requests__r.size();
                if (currentLoad < minLoad) {
                    minLoad = currentLoad;
                    bestVendor = v;
                }
            }
            req.Vendor__c = bestVendor.Id;
        }
    }
}