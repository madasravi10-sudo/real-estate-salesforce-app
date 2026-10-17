trigger contacttrigger on Contact (after delete) {
    if(trigger.isbefore && trigger.isdelete){
        list<messaging.SingleEmailMessage> emailobjs =new list<Messaging.SingleEmailMessage>();
        for(contact conOld : trigger.old){
            
            Messaging.SingleEmailMessage emailobj= new Messaging.SingleEmailMessage();
            list<string> emailaddress = new list< string>();
            emailaddress.add(Userinfo.getUserEmail());
            emailobj.setToAddresses(emailaddress);
            emailobj.setSubject('contact deleted sucessfully'+conOld.name);
            emailobj.setPlainTextBody('hello not written anythimng');
            emailobjs.add(emailobj);
            }
        Messaging.sendEmail(emailobjs);
    }

}