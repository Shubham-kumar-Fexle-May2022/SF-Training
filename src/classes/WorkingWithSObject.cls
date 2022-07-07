/*      
    *   @Description    :    How to work on sObjects. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    06/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class WorkingWithSObject {
    // Method

    /* 
        *    @Description    :      How to Insert data in sObject with different-2 types.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    // DML -> DML stands for data manipulation language, which is used for insert, update, delete, undelete a particular record into/from salesforce database.

    public static void insertData() {
        Account acc1 = new Account();
        // Property Initialization or Field Initialization

        // Type-1
        acc1.Name = 'Rohan';
        acc1.AccountNumber = '112';
        acc1.Phone = '9627088913';
        // DML Query
        insert acc1;
        System.debug('Record-1 inserted successfully');
        
        // Type-2
        Account acc2 = new Account(Name = 'Sobhit', AccountNumber = '113', Phone = '9719727950');
        // DML Query
        insert acc2;
        System.debug('Record-2 inserted successfully'); 

        // Type-3
        sObject s = new Account();
        s.put('Name','Rocky');
        s.put('AccountNumber','115');
        s.put('Phone','9632569225');
        insert s;
        System.debug('Record-3 inserted successfully');
    }

    /* 
        *    @Description    :      Understand sObject type casting.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public static void instanceOfKeyword() {
        sObject s = new Account();

        // This is one is correct type casting
        Account a = (Account)s;

        // It is wrong. Run time error
        //Contsct c = (Contact)s;

        if(s instanceOf Account) {
            Account acc =(Account)s;
            System.debug('This is Account type');
        } else if(s instanceOf Contact) {
            Contact c = (Contact)s;
            System.debug('This is Contact type');
        }
    }

    /* 
        *    @Description    :      How to Insert data in custom object.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    public static void insertDataInCustomObject() {
        Pan_Card__c obj = new Pan_Card__c();
        obj.Name = 'Seema';
        obj.Pan_Number__c = 'LNMPJ10256';
        obj.Father_s_Name__c = 'Ramprasad';
        obj.Address__c = 'Mathura';
        obj.Date_Of_Birth__c = date.parse('01/10/2001');

        insert obj;
        System.debug('Record inserted successfully');
    }

    /* 
        *    @Description    :      How to Update record of a custom object.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    public static void updateRecord() {
        Student__c std = [Select Id, Name, Address__c, City__c, Email__c, Class__c From Student__c Where Name = 'Dharmesh Kumar'];
        std.City__c = 'Jaipur';
        std.Class__c = 'BBA';
        std.Email__c = 'dharmesh123@gmail.com';

        try {
            update std;
            System.debug('Record updated successfully');
        } catch(Dmlexception e) {
            System.debug(e);
        }
    }

    /* 
        *    @Description    :      Object typecasting .
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    public static void typeCasting() {
        Account a = new Account(Name = 'Acme', BillingCity = 'San Francisco');
        insert a;
        sObject s = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];
        ID id = s.ID;
        Account convertedAccount = (Account)s;
        convertedAccount.name = 'Acme2';
        update convertedAccount;
        Contact con = new Contact(FirstName = 'Sal', Account = convertedAccount);
        insert con;
    }
}