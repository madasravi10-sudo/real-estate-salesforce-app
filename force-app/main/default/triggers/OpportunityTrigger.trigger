trigger OpportunityTrigger on Opportunity (after insert) {

    for(Opportunity opp : Trigger.new){

        Account acc = [SELECT Id, name FROM Account WHERE Id = :opp.AccountId];

        acc.name = acc.name + opp.Amount;
update acc;
    }
}