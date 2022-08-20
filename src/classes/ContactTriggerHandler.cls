/*      
    *   @Description    :    In this class we are checking deplicate contacts and throug an error.
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    27/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar                            
*/

public with sharing class ContactTriggerHandler {

    /*
        *    @Description    :      In this method we check full duplicate record according to apply some conditions and also check partial duplicacy on it.
        *
        *    @args           :       List<Contact>
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  27/07/2022  - Shubham Kumar 
        *                                    
    */

    public static void checkDuplicateRecords(List<Contact> newConList) {

        // Check Full Duplicate Records.
        List<Contact> conList = [Select Id, LastName, Phone, Email From Contact];
        for(Contact c1 : newConList) {
            for(Contact c2 : conList) {
                If(c1.LastName == c2.LastName && c1.Phone == c2.Phone && c1.Email == c2.Email) {
                    c1.addError('this contact is a full duplicate so use the one which is already created!!');
                }

                // Check Partial duplicate records.
                If(c1.LastName == c2.LastName && c1.Phone == c2.Phone) {
                    c1.Potential_Duplicate__c = true;
                    c1.Related_Duplicate__c = 'Last Name - ' + c2.LastName + '  Phone - ' + c2.Phone;
                }
                else If (c1.LastName == c2.LastName && c1.Email == c2.Email) {
                    c1.Potential_Duplicate__c = true;
                    c1.Related_Duplicate__c = 'Last Name - ' + c2.LastName + '  Email - ' + c2.Email;
                }
                else If (c1.Phone == c2.Phone && c1.Email == c2.Email) {
                    c1.Potential_Duplicate__c = true;
                    c1.Related_Duplicate__c = 'Phone - ' + c2.Phone + '   Email - ' + c2.Email;
                }
            }
        }    
    }

    /*
        *    @Description    :      Sync contact with related account and property object and populate Account and property status in contact object.
        *
        *    @args           :       List<Contact>
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  15/08/2022  - Shubham Kumar 
        *                                    
    */

    public static void syncContactWithAccountAndProperty(List<Contact> newConList) {
        Set<Id> setOfAccIds = new Set<Id>();
        for(Contact con : newConList) {
            setOfAccIds.add(con.AccountId);
        }
        List<Account> accList = [Select Id, Name, Status__c, Property__c From Account Where Id In: setOfAccIds];
        System.debug('accList ==> ' + accList);
        

        // Map of Account
        Map<Id, Account> mapOfAcc = new Map<Id, Account>();
        mapOfAcc.putAll(accList);
        System.debug('mapOfAcc ==> ' + mapOfAcc);
        // Map of Property
        // Map<Id, Property__c> mapOfProperty = new Map<Id, Property__c>();
        // mapOfProperty.putAll(propList);
        for(Contact con : newConList) {
            If(con.Status__c == null) {
                Account acc = mapOfAcc.get(con.AccountId);
                If(acc.Status__c != null) {
                    con.Status__c = acc.Status__c;
                }
            }
        }
    }
}