public class getAccountsList {
    @AuraEnabled(cacheable=true)
    public static list<account> acountlist(){
        list<account> acclist=[select id,name,phone,rating from account];
        system.debug('acclist=='+acclist);
        return acclist;
        }
}