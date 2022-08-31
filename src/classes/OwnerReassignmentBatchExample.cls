/*      
    *   @Description    :    Batch Apex Example. (This class will prform the whole operation on Account object).
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    28/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

public class OwnerReassignmentBatchExample implements Database.Batchable<sObject>{
    String query;
    String email;
    Id toUserId;
    Id fromUserId;
    
    /* 
        *    @Description    :       start Method.
        *
        *    @args           :       Database.BatchableContext
        *
        *    @return         :       Database.querylocator
        *
        *    @revision Log   :       V1.1  - Created  -  28/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public Database.querylocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(query);
    }
    
    /* 
        *    @Description    :       execute Method.(Execute Repeatedly)
        *
        *    @args           :       Database.BatchableContext, List<sObject>
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  28/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Account> accns = new List<Account>();
    
        for(sObject s : scope) {
        Account a = (Account)s;
            if(a.OwnerId==fromUserId){
                a.OwnerId=toUserId;
                accns.add(a);
                }
        }
        update accns;    
    }

    /* 
        *    @Description    :       Finish Method.(This method was run only once after the completion of all the batches.)
        *
        *    @args           :       Database.BatchableContext
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  28/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public void finish(Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {email});
        mail.setReplyTo('batch@acme.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }

    // To execute this class write down the following code on anonymous widow.

    /*OwnerReassignment reassign = new OwnerReassignment();
    reassign.query = 'SELECT Id, Name, Ownerid FROM Account ' + 
                    'WHERE ownerid=\'' + u.id + '\'';
    reassign.email='admin@acme.com';
    reassign.fromUserId = u;
    reassign.toUserId = u2;
    ID batchprocessid = Database.executeBatch(reassign);*/
}