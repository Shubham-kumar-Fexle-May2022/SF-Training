/*      
    *   @Description    :    Upsert records using DML. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    10/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class UpsertingRecordsInApex {
    // Upsert the record in Account.
    public UpsertingRecordsInApex() {
        Account[] acctsList = [SELECT Id, Name, BillingCity FROM Account WHERE BillingCity = 'Bombay'];
        for (Account a : acctsList) {
            a.BillingCity = 'Mumbai';
        }
        System.debug(acctsList);
        Account newAcct = new Account(Name = 'Acme', BillingCity = 'San Francisco');
        acctsList.add(newAcct);
        System.debug(acctsList);
        try {
            upsert acctsList;
            System.debug(acctsList);
        } catch (DmlException e) {
            System.debug(e);
        }
    }

    /* 
        *    @Description    :      Deleteb account using DML.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  10/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // Delete record from Account object.
    public static void deleteAccount() {
        Account[] accts = [SELECT Id, Name FROM Account WHERE Name = 'DotCom']; 
        try {
            delete accts;
            System.debug('Record deleted successfully');
        } catch (DmlException e) {
            // Process exception here
        }
    }

    /* 
        *    @Description    :      Delete contact.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  10/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // Delete the record of Contact Object.
    public static void deleteContact() {
        Contact[] con = [Select id, FirstName, LastName From Contact Where Name = 'Madhu Kumari'];
        delete con;
        System.debug('Record deleted successfully');
    }

    /* 
        *    @Description    :      Exception handling (Math.Exception devide by zero).
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void exceptionHandling() {
        // Integer num = 10/0;  This will generate (Math.Exception devide by 0).
        /* If we want to execute our program properly then we use try & catch block for handle this exception ,
         In try block we put Error statements and inside the catch we display the exception */
        try {
            Integer num = 40/0;
        } catch(Exception e) {
            System.debug('Value is infinity - ' + e.getMessage());           
        }
    }

    /* 
        *    @Description    :      Exception handling (List index out of bound).
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void listException() {
        try {
            List<String> listOfString = new List<String>{'Renu','Komal','Seema'};
            System.debug(listOfString.get(0));
            System.debug(listOfString.get(1));
            System.debug(listOfString.get(2));

            System.debug(listOfString.get(3)); // This will generate a exception(Without try & catch) ListException(List index out of bounds).
        } catch(Exception e) {
            System.debug('There is no value on this index : ' + e.getMessage());
        }
    }

    /* 
        *    @Description    :      Exception handling (insert failed exception, Required field missing).
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void insertFailedException() {
        Student__c s = new Student__c();
        // insert s; This will generate a exception without try & catch (insert failed)
        
        try {
            Student__c m = new Student__c();
            insert s;
            System.debug('Statement after insert');  // Not executed by the compiler.
        } catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        System.debug('Ststement outside the try & catch');
    }
}