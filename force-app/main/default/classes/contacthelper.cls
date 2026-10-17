public class contacthelper {
    public static void createcontacts(){
        list<contact> lstcons=new list<contact>();
        for(integer i=1; i<50;i++){
            contact con =new contact();
            con.lastname='lastname'+i;
            con.phone='89797768'+i;
            con.email='madasravindergoud@gmail.com'+i;
            lstcons.add(con);
        }
        insert lstcons;
        system.debug( 'contact names..:'+lstcons.size());
    }
}