trigger preventofaccountrecordrelatdopps on account(before delete){
if(trigger.isbefore && trigger.isdelete){
for(account acc:trigger.old){
list<opportunity> lstopps=[select id ,stagename,amount from opportunity where accountId=:acc.Id];
if(lstopps.size()>0){
acc.adderror('you cant delete this account beacuse its having opps');
}
}
}
}