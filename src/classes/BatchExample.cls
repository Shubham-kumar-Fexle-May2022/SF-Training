/*      
    *   @Description    :    Batch Apex Example. (This class will prform the whole operation on Account object).
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    30/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

global class BatchExample implements Database.Batchable<sObject> {

    // start method. (This will call only ones)
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
        
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
    
    // execute method. (This will call repeatedly until the all batches are finished).
    global void execute(Database.BatchableContext BC, List<Account> accList) {
       
        // process each batch of records
        for(Account acc : accList)
        {        
           	// Update the Account Name 
            acc.Name = acc.Name + 'Webkul';
        }
        try {
        	// Update the Account Record
            update accList;
        
        } catch(Exception e) {
            System.debug(e);
        }
        
    }   
    
    global void finish(Database.BatchableContext BC) {
    	// execute any post-processing operations
        System.debug('This is finished!');
  }
}