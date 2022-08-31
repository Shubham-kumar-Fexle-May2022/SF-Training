/*      
    *   @Description    :    In this class we see a small example with future method.                       
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    23/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar                            
*/

public with sharing class FutureMethodExamples {

    /* 
        *    @Description    :      Update Email.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  23/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // Update email where industry is banking.
    public void updateEmail(){
        List<Account> acc = [Select id, Email__c, phone from Account Where industry = 'banking'];
        for(Account a : acc){
            a.Email__c = 'salman@gmail.com';
            update a;
        }
    }

    // Update email where industry is Education.
    @future
    public static void futureMethod(){
        List<Account> acc = [Select id, Email__c, phone from Account Where industry = 'Education'];
        for(Account a : acc){
            a.Email__c = 'Test@gmail.com';
            update a;
        }
    }

    public void methodCalling(){
        updateEmail(); // Method calling
        futureMethod(); // Method calling
    }
}