/**
    *  Purpose         :  This trigger is to handle all the pre and post processing operations for Account objects.
    *
    *  Created By      :  Shubham kumar
    *
    *  Created Date    :  20/07/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/
// Here we used 3 events - before insert, after insert and before update

trigger Trigger_Account on Account (before insert, after insert, before update) {
    If(Trigger.isBefore) {
        If(Trigger.isInsert) {
            AccountTriggerHandler.addAccountNumberWithType(Trigger.New);
        }
        If(Trigger.isInsert || Trigger.isUpdate) {
            AccountTriggerHandler.insertAndUpdateRecord(Trigger.New);
        }
    }
    If(Trigger.isAfter) {
        If(Trigger.isInsert) {
        AccountTriggerHandler.sendEmailNotification(Trigger.New);
        }
    }
}