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