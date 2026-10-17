trigger OpportunityManager on Opportunity (after update) {
 set<id> oppids= new set<id>();
    if(Trigger.isafter || Trigger.isUpdate){
        for(Opportunity opp: Trigger.new){
            if(opp.accountid!=null)
            oppids.add(opp.AccountId);
        }
    }
   
  List<AggregateResult> aggResult = [SELECT AccountId , SUM(Amount) sumAmt
                                FROM Opportunity
                                WHERE AccountId IN :oppIds
                                GROUP BY AccountId]; 
    List<Account> lstaccs = new List<Account>();
    for(AggregateResult agg: aggResult){
        Account acc = new Account();
        acc.Id = (Id)agg.get('AccountId');
        acc.AnnualRevenue = (Decimal)agg.get('sumAmt');
        lstaccs.add(acc);
    }
    update lstaccs;
}