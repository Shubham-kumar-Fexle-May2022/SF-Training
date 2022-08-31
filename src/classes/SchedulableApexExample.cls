/*      
    *   @Description    :    Schedulable Apex. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    30/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

global with sharing class SchedulableApexExample implements Schedulable {

    // This test runs a scheduled job at midnight Sept. 3rd. 2022
   public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    /* 
        *    @Description    :      Execute Method.
        *
        *    @args           :       SchedulableContext
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  30/08/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    global void execute(SchedulableContext sc) {
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                  FROM CronTrigger WHERE Id = :sc.getTriggerId()];    
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));  
        Account a = [SELECT Id, Name FROM Account WHERE Name = 
                    'testScheduledApexFromTestMethod'];
        a.name = 'testScheduledApexFromTestMethodUpdated';
        update a;
    }   
}