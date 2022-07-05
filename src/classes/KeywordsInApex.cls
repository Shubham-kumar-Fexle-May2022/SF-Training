/*      
    *   @Description    :    final & this keyword with implementation 
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    02/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class KeywordsInApex {

    private static final Integer num = 10;
    private static final Double pi = 3.14;

    /* 
        *    @Description    :      Implement final keyword 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    // Final -> It is used for define a valus as an constant , we can not do change valus of a final variable after initialized it.

    public void finalKeyword() {
        Integer num2 = 50;
        final Integer  c = 10;
        System.debug('final variable value in local -> ' + c);
        Double radius = 50.0;
        System.debug('Are of Circle = ' + KeywordsInApex.pi * radius * radius);
        System.debug('Instance variable = ' + KeywordsInApex.num);
        //num = 20;  We can not change the value of final keyword because it is a constant.
        System.debug('Local variable = ' + num2);
    }

    /* 
        *    @Description    :      Implement this keyword 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    // this -> It is used for reference to instance variable and for access current class methods and constructor


    Boolean bool = true;
    public void thisKeyword() {
        Boolean bool = false;
        System.debug('Using this keyword -> ' + this.bool);
        System.debug('Without using this keyword -> ' + bool);

        // calling of current class method
        this.finalKeyword();
    }

    /* 
        *    @Description    :      Implement instanceOf keyword 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  03/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    public static void InstanceOfKeyword() {

        sObject s = new Account();
    
        // This one is correct type casting
        Account a = (Account)s;

        // This is wrong typecasting
        //Contact c = (Contact)s;

        if(s instanceOf Account) {
            Account acc = (Account)s;
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