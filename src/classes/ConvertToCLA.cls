/*      
    *   @Description    :    Convert sObjects datatype to Lead , Account & Contact. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    07/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing class ConvertToCLA {
    
    List<Contact> contacts = new List<Contact>();
    List<Lead> leads = new List<Lead>();
    List<Account> accounts = new List<Account>();
    
    // Method with String argument
    public void convertType(String phoneNumber) {
        List<List<SObject>> results = [FIND :phoneNumber 
            IN Phone FIELDS 
            RETURNING Contact(Id, Phone, FirstName, LastName), 
            Lead(Id, Phone, FirstName, LastName), 
            Account(Id, Phone, Name)];
        List<SObject> records = new List<SObject>();
        records.addAll(results[0]); //add Contact results to our results super-set
        records.addAll(results[1]); //add Lead results
        records.addAll(results[2]); //add Account results
 
        if (!records.isEmpty()) { 
            for (Integer i = 0; i < records.size(); i++) { 
                SObject record = records[i];
                if (record.getSObjectType() == Contact.sObjectType) { 
                    contacts.add((Contact) record);
                } else if (record.getSObjectType() == Lead.sObjectType){ 
                    leads.add((Lead) record);
                } else if (record.getSObjectType() == Account.sObjectType) { 
                    accounts.add((Account) record); 
                }
            }
        }
        displayUpdatedList();
    }
    
    /* 
        *    @Description    :      Dispaly updated list.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  05/07/2022  - Shubham Kumar  - Used for Practise
        *                                    Modified -  06/07/2022  - Shubham Kumar
    */ 

    public void displayUpdatedList() {
        System.debug('List of Contacts -> ' + contacts);
        System.debug('List of Leads -> ' + leads);
        System.debug('List of Account -> ' + accounts);
    }
}