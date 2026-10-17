public class accounthelper {
    public static void createaccountcontactopp(){
        list<account> lstaccs =new list<account>();
        account acc=new account();
        acc.name='veljala shireesha';
        acc.phone='9652668617';
        acc.fax='787978';
        lstaccs.add(acc);
        insert lstaccs;
    system.debug('account are ..:'+lstaccs.size());
    list<contact> lstcons=new list<contact>();
    for(integer i=1; i<=2; i++){
    contact con =new contact();
        con.lastname=acc.name+i;
        con.phone=acc.phone+i;
        con.accountid=acc.id;
        lstcons.add(con);
    }
    insert lstcons;
        system.debug('contact are...:'+lstcons.size());
        list<opportunity> lstopps= new list<opportunity>();
        for(integer i=1; i<=5 ;i++){
            opportunity opp=new opportunity();
            opp.name='ravinder goud'+i;
            opp.CloseDate=date.today()+i;
            opp.StageName='prospecting'+i;
            opp.accountid=acc.id;
            lstopps.add(opp);
        }
        insert lstopps;
        system.debug('opportunities count are..:'+lstopps.size());
        }     
  
    }