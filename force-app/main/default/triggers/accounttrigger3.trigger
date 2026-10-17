trigger accounttrigger3 on Account (after delete) {
    if(trigger.isafter && trigger.isdelete){
        list<Messaging.SingleEmailMessage> emailobjs=new List<Messaging.SingleEmailMessage>();
        for(account accOld:trigger.old){
            Messaging.SingleEmailMessage emailObj=new messaging.SingleEmailMessage();
            list<string> emailAddress =new list<string>();
            emailaddress.add(Userinfo.getUserEmail());
            emailobj.setToaddresses(emailaddress);
            emailobj.setSubject('account has been sucessfully deleted'+ accOld.name);
            emailobj.setplaintextBody('hello..no body written here... please refer subject');
            emailobjs.add(emailobj);
                                     }
        Messaging.sendEmail(emailobjs);
    }

}