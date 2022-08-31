/*      
    *   @Description    :    Queueable Apex Example. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    24/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

public with sharing class QueueableApex implements Queueable {
    /* 
        *    @Description    :      Execute method.
        *
        *    @args           :       QueueableContext
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  24/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */
    public void execute(QueueableContext cn) {
        List<Account> listToUpdate = new List<Account>();
        for(Account acc : [Select Id, Name, Type From Account Where Type = 'Customer - Direct']) {
            acc.Type = 'Prospect';
            listToUpdate.add(acc);
        }
        If(!listToUpdate.isEmpty()) {
            update listToUpdate;
        }
    }
}