public class contactHandler {
    @AuraEnabled(cacheable=true)
    public static list<contact> conlist(){
        list<contact> conlist=[select id,name,lastname,leadsource,phone from contact];
        system.debug('conlist=='+conlist);
        return conlist;
    }
}