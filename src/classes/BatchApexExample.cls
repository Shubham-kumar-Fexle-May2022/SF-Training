/*      
    *   @Description    :    Batch Apex Example. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    24/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

public with sharing class BatchApexExample implements Database.Batchable<SObject> {
    /* 
        *    @Description    :       start Method.
        *
        *    @args           :       Database.BatchableContext
        *
        *    @return         :       Database.QueryLocator
        *
        *    @revision Log   :       V1.1  - Created  -  24/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // This method will run only once.
    public Database.QueryLocator start(Database.BatchableContext bc) {
        /* Here we have Two return type.
        1. Database.QueryLocator -> The governer limit of records retrieved by SOQL queries is bypassed.
        2. Iterable<sObject> -> Gonerner limits will be enforced.*/
        String query = 'Select Id, Description, Name From Opportunity Where isClosed = true';
        return Database.getQueryLocator(query);
    }

    /* 
        *    @Description    :      execute Method.(Execute Repeatedly)
        *
        *    @args           :       Database.BatchableContext, List<Opportunity>
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  24/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */
    // This method will run repaetedly until completed all batches.
    public void execute(Database.BatchableContext bc, List<Opportunity> records) {
        // Records are processed in batches.
        List<Opportunity> listToUpdate = new List<Opportunity>();
        for(Opportunity obj : records) {
            obj.Description = 'Opportunity Closed';
            listToUpdate.add(obj);
        }
        If(!listToUpdate.isEmpty()) {
            update listToUpdate;
        }
    }
    /* 
        *    @Description    :      Finish Method.(This method was run only once after the completion of all the batches.)
        *
        *    @args           :       Database.BatchableContext
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  24/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */
    public void finish(Database.BatchableContext bc) {
        // This method will execute after completion all the process.
    }
}