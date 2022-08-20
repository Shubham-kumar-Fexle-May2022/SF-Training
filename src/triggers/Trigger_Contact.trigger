/**
    *  Purpose         :  This trigger is to handle all the pre and post processing operations for Contact object.
    *
    *  Created By      :  Shubham kumar
    *
    *  Created Date    :  27/07/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/

trigger Trigger_Contact on Contact (before insert, before update) {
    If(Trigger.isBefore) {
        If(Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.checkDuplicateRecords(Trigger.New);
            ContactTriggerHandler.syncContactWithAccountAndProperty(Trigger.New);
        }
    }  
}