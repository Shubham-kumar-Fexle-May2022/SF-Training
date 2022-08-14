/**
    *  Purpose         :  This trigger is to handle all the pre and post processing operations for Opportunity object.
    *
    *  Created By      :  Shubham kumar
    *
    *  Created Date    :  27/07/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/

trigger Trigger_Opportunity on Opportunity (before insert, after insert, after update, before delete) {
    If(Trigger.isAfter) {
        If(Trigger.isInsert || Trigger.isUpdate) {
            OpportunityTriggerHandler.insertAndUpdateRecords(Trigger.New, Trigger.oldMap);
        }
    }
}