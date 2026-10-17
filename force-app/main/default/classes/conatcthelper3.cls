public class conatcthelper3 {
public static void InsertBulkContacts(Integer maxRecords) {

        if (maxRecords > 0) {

            // Create Contact List
            List<Contact> lstContacts = new List<Contact>();

            // Loop to create Contacts
            for (Integer counter = 1; counter <= maxRecords; counter++) {

                Contact con = new Contact();
                con.FirstName = 'Bulk';
                con.LastName = 'Insert - ' + counter;
                con.Email = 'bulkContact' + counter + '@gmail.com';
                con.Title = 'Sales Manager';
                con.Department = 'Sales Department';
                con.Phone = '9900990000';
                con.Fax = '9900990000';
                con.MailingStreet = 'Gayathri Nagar';

                // PAN Number (intentional failure for record 198)
                if (counter != 198) {
                    con.lastname= '';
                }

                // Add contact to list
                lstContacts.add(con);
            }

            // Insert Contacts with partial success
            if (!lstContacts.isEmpty()) {

                Database.SaveResult[] results =
                    Database.insert(lstContacts, false);

                // Track Success & Errors
                for (Database.SaveResult res : results) {

                    if (res.isSuccess()) {
                        System.debug(
                            'Record inserted successfully. Record Id: ' +
                            res.getId()
                        );
                    } else {
                        for (Database.Error err : res.getErrors()) {
                            System.debug('Error Message: ' + err.getMessage());
                            System.debug('Status Code: ' + err.getStatusCode());
                            System.debug('Error Fields: ' + err.getFields());
                        }
                    }
                }
            }
        }
    }
}