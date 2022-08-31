/*      
    *   @Description    :    Batch Apex Delete Example. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    28/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

public class BatchDeleteExample implements Database.Batchable<sObject> {
    public String query;

    // start method
    public Database.QueryLocator start(Database.BatchableContext BC){
       return Database.getQueryLocator(query);
    }
    
    // execute method
    public void execute(Database.BatchableContext BC, List<sObject> scope){
       delete scope;
       DataBase.emptyRecycleBin(scope);
    }
    
    // finish method
    public void finish(Database.BatchableContext BC){
        // This method will execute after all batches completed
    }
 }