/**
    *  Purpose         :  This trigger is to handle all the pre and post processing operations for Opportunity object.
    *
    *  Created By      :  Shubham kumar
    *
    *  Created Date    :  16/08/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/

trigger Trigger_State on State__c (after insert, after delete, after update) {
    If(Trigger.isAfter) {
        If(Trigger.isUpdate) {
            StateTriggerHandler.updateStateAndCountryIfStateIsUpdated(Trigger.New, Trigger.Old);
        }
        If(Trigger.isInsert) {
            StateTriggerHandler.updateStateAndCountryIfStateIsInserted(Trigger.New);
        }
        If(Trigger.isDelete) {
            StateTriggerHandler.updateStateAndCountryIfStateIsDeleted(Trigger.Old);
        }
    }
}