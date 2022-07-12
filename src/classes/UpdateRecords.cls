/*      
    *   @Description    :    Update records using DML Queries. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    08/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing class UpdateRecords {
    // Constructor
    public UpdateRecords() {
        List<Contact> conList = [Select Department , Description from Contact Where Name = 'Akash Singh'];
        for(Contact con : conList) {
            if (con.Department == 'Finance') {
                con.Description = 'New description';
            }
            // Not a good practice since governor limits might be hit.
            update con;
            System.debug('Record updated successfully!');
            System.debug('Selected List -> ' + conList);
            System.debug(con);
        }
    }

    /* 
        *    @Description    :      Update Records using DML.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void updateRecordWithList() {
        // List to hold the new contacts to update.
        List<Contact> updatedList = new List<Contact>();
        List<Contact> conList = [Select Department , Description from Contact];
        for(Contact con : conList) {
            if (con.Department == 'Finance') {
                con.Description = 'New description';
                // Add updated contact sObject to the list.
                updatedList.add(con);
            }
        }
        // Call update on the list of contacts.
        // This results in one DML call for the entire list.
        update updatedList;
        System.debug('Record updated successfully');
        System.debug('Updated Lits -> ' + updatedList);
    }

    /* 
        *    @Description    :      Update Account record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */
    public void updateAccountRecords() {
        Account a = new Account(Name='Account Example');
        insert a;
        // Query existing account.
        Account a1 = [SELECT Name,Industry FROM Account WHERE Name='Account Example' LIMIT 1];

        // Write the old values the debug log before updating them.
        System.debug('Account Name before update: ' + a.Name); // Name is Account Example
        System.debug('Account Industry before update: ' + a.Industry);// Industry is not set

        // Modify the two fields on the sObject.
        a1.Name = 'Account of the Day';
        a1.Industry = 'Technology';

        // Persist the changes.
        update a1;
        System.debug('Record updated successfully!');

        // Get a new copy of the account from the database with the two fields.
        Account acc = [SELECT Name,Industry FROM Account WHERE Name='Account of the Day' LIMIT 1];

        // Verify that updated field values were persisted.
        System.assertEquals('Account of the Day', acc.Name);
        System.assertEquals('Technology', acc.Industry);
        System.debug('After update The List -> ' + acc);
    }

    /* 
        *    @Description    :      Insert and update record of Account.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void insertAndUpdateRecords() {
        Account[] accts = new List<Account>();
        for(Integer i=0;i<3;i++) {
            Account a = new Account(Name='Acme' + i, BillingCity='San Francisco');
            accts.add(a);
        }
        Account accountToUpdate;
        try {
            insert accts;
            System.debug('Before update List -> ' + accts);        
            
            // Update account Acme2.
            accountToUpdate = [SELECT BillingCity FROM Account WHERE Name='Acme2' AND BillingCity='San Francisco'LIMIT 1];
            // Update the billing city.
            accountToUpdate.BillingCity = 'New York';
            // Make the update call.
            update accountToUpdate;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }

        // Verify that the billing city was updated to New York.
        Account afterUpdate = [SELECT BillingCity FROM Account WHERE Id=:accountToUpdate.Id];
        System.assertEquals('New York', afterUpdate.BillingCity);
        System.debug('After update List -> ' + afterUpdate);
    }

    /* 
        *    @Description    :      Insert related record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void insertRelatedRecords() {
        try {            
            Account acct = new Account(Name='SFDC Account');
            insert acct;
        
            // Once the account is inserted, the sObject will be 
            // populated with an ID.
            // Get this ID.
            ID acctID = acct.ID;
        
            // Add a contact to this account.
            Contact con = new Contact(FirstName='Joe',LastName='Smith',Phone='415.555.1212',AccountId=acctID);
            insert con;
            System.debug('Record inserted successfully!');
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    /* 
        *    @Description    :      Update related record.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void updatingRelatedRecords() {
        try {
            // Query for the contact, which has been associated with an account.
            Contact queriedContact = [SELECT Account.Name FROM Contact WHERE FirstName = 'Joe' AND LastName='Smith' LIMIT 1];
            
            System.debug('Selected record -> ' + queriedContact);
            // Update the contact's phone number
            queriedContact.Phone = '415.555.1213';
        
            // Update the related account industry
            queriedContact.Account.Industry = 'Pharmaceutical';
        
            // Make two separate calls 
            // 1. This call is to update the contact's phone.
            update queriedContact;
            System.debug('After updated related list -> ' + queriedContact);
            // 2. This call is to update the related account's Industry field.
            update queriedContact.Account; 
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    /* 
        *    @Description    :      Insert record in Opportunity.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  09/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void insertRecordInOpportunity() {
        Opportunity newOpportunity = new Opportunity(Name = 'OpportunityWithAccountInsert', StageName = 'Prospecting', CloseDate = Date.today().addDays(7));

        // Create the parent record reference.
        // An account with external ID = 'SAP111111' already exists.
        // This sObject is used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(MyExtID__c = 'SAP111111');                

        // Add the account sObject to the opportunity.
        newOpportunity.Account = accountReference;

        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
        System.debug('Record inserted successfully!');
    }

    /* 
        *    @Description    :      Insert related records.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void insertRelatedRecord() {
        try{
            HOD__c obj = new HOD__c(Name = 'Manoj Shukla');
            insert obj;

            ID objId = obj.ID;

            Teacher__c tech = new Teacher__c(Name = 'Kanha', Address__c = 'Delhi', Phone__c = '9627088916', HOD__c = 'objId', College_Code__c = 'a075i0000016vzCAAQ');
            insert tech;
        } catch(Exception e) {
            System.debug('An unexpected error!!');
        }
        System.debug('record inserted!');
    }

    /* 
        *    @Description    :      Update related records.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void updateReletedRecordOfCustomObject() {
       try {
        HOD__c hodName = new HOD__c(Name = 'Reena');
        insert hodName;

        ID hodNameId = hodName.ID;

        Teacher__c techName = new Teacher__c(Name = 'Sohan', HOD__c = hodNameId, College_Code__c = 'a075i0000016wQtAAI');
        insert techName;

        ID techNameId = techName.Id;

        Student__c stuName = new Student__c(Name = 'Pankaj', Teacher__c = techNameId);
        insert stuName;
        } catch(Exception e) {
            System.debug('Error occur!' + e.getMessage());
        }
        System.debug('Record inserted successfully!');

        try{
            Teacher__c teacherQuery = [Select HOD__r.Name, HOD__r.Department__c From Teacher__c Where Name = 'Pradeep' LIMIT 1];
            teacherQuery.HOD__r.Department__c = 'BBA';
            update teacherQuery;

            Student__c stuQuery = [Select Teacher__r.HOD__r.Name From Student__c Where Name = 'Pankaj' LIMIT 1];

            HOD__c updateHOD = new HOD__c(Id = stuQuery.Teacher__r.HOD__c, Department__c = 'LLB');
            update updateHOD;
        } Catch(Exception e) {
            System.debug('Error occur: ' + e.getMessage());
        }
        System.debug('Record updated successfully!');
    }
}