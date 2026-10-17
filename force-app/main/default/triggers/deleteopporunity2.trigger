trigger deleteopporunity2 on Opportunity (before delete,after update ) {
  if(trigger.isbefore && trigger.isdelete && trigger.isafter && trigger.isupdate){
      /**  get current user profile***///
           Profile p = [
            SELECT Name
            FROM Profile
            WHERE Id = :UserInfo.getProfileId()
            LIMIT 1
        ];

      for(opportunity opp:trigger.new){
           if (opp.IsClosed && p.Name != 'System Administrator') {
                opp.addError(
                    'Only Admin can delete Closed Opportunities.'
                );
              
          }
      }
        }
    /** send email when opportunity closed won*/////
    if(trigger.isafter && trigger.isupdate){
        list<messaging.singleemailmessage> email =new list<messaging.singleemailmessage>();
        for(opportunity opp:trigger.new){
            opportunity oppold=trigger.oldmap.get(opp.id);
        
       if (
                opp.StageName == 'Closed Won' &&
                oppold.StageName != 'Closed Won'
            ) {
                 messaging.singleemailmessage emailobj=new messaging.singleemailmessage();
                emailobj.setTargetObjectId(opp.OwnerId);
                emailobj.setSaveAsActivity(false);
                emailobj.setsubject('opportunity closed won');
                emailobj.setplaintextbody('we dont have any text please chcek subject');
                email.add(emailobj);
                }
        if(!email.isempty()){
            messaging.sendemail(email);
        }
    }
}  
}