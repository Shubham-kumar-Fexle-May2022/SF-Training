/**
    *  Purpose         :  This trigger is to handle all the pre and post processing operations for Opportunity object.
    *
    *  Created By      :  Shubham kumar
    *
    *  Created Date    :  10/08/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/

trigger Trigger_District on District__c (before insert, after insert, before delete, after delete, before update, after update) {
    If(Trigger.isAfter) {
        If(Trigger.isUpdate) {
            DistrictTriggerHandler.updateDistrictStateAndCountryIfDistrictIsUpdated(Trigger.New,Trigger.Old);
        }
        If(Trigger.isDelete) {
            DistrictTriggerHandler.updateDistrictStateAndCountryIfDistrictIsDeleted(Trigger.Old);
        }
        If(Trigger.isInsert) {
            DistrictTriggerHandler.updateDistrictStateAndCountryIfDistrictIsInserted(Trigger.New);
        }
    }
}