/*      
    *   @Description    :    Understand the working of instanceOf Keyword.
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    03/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class InstanceOfKeyword {

    sObject s = new Account();
    
    // This one is correct type casting
    Account a = (Account)s;

    // This is wrong typecasting
    //Contact c = (Contact)s;

    // Constructor 
    public InstanceOfKeyword() {
        if(s instanceOf Account) {
            Account a = (Account)s;
            System.debug('This is a Account type');
        } else if(s instanceOf Contact) {
            Contact c = (Contact)s;
            System.debug('This is a Contact type');

        }

        // Create o variable of Object type and checking it is a instanceOf Account or not, Then we got false result .
        Object o = null;
        Boolean result = o instanceof Account;
        System.debug(result);
    }
}