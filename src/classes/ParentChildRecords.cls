/*      
    *   @Description    :    Access parent to child and child to parent records. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    09/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class ParentChildRecords {

    /* 
        *    @Description    :      Insert parent child record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void InsertParentChild() {
        Date dt = Date.today();
        dt = dt.addDays(7);
        System.debug(dt);
        Opportunity newOpportunity = new Opportunity(Name='OpportunityWithAccountInsert', StageName='Prospecting', CloseDate=dt);
        
        // Create the parent reference.
        // Used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(MyExtID__c = 'SAP111111');                
        newOpportunity.Account = accountReference;
        
        // Create the Account object to insert.
        // Same as above but has Name field.
        // Used for the insert.
        Account parentAccount = new Account(Name='Hallie', MyExtID__c='SAP111111');      
        
        // Create the account and the opportunity.
        Database.SaveResult[] results = Database.insert(new SObject[] {parentAccount, newOpportunity });
        
        // Check results.
        for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                System.debug('Successfully created ID: ' + results[i].getId());
            } else {
                System.debug('Error: could not create sobject '+ 'for array element ' + i + '.');
                System.debug('The error reported was: ' + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }

    /* 
        *    @Description    :      Retrieve child to parent record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void contactToAccount() {
        List<Contact> con = [Select Id, Name, Phone, Account.Name From Contact Where Name = 'Joe Smith'];
        System.debug('Account List -> ' + con);
        for(Contact c : con) {
            System.debug('Contact Name- ' + c.Name + ' Account name- ' + c.Account.Name);
        }         
    }

    /* 
        *    @Description    :      Insert parent to child record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // Insert  related record account to contact.
    public static void insertRecordAccountToContact() {
        Account acc=new Account(Name='Blog Acc1');
        insert acc;
        System.debug('Account Inserted Successfully.');

        Contact cont=new Contact(FirstName='Bob', LastName='Buzzard', AccountId=acc.id);
        insert cont;
        System.debug('Contact Inserted Successfully.');
    }
}