trigger OrderTrigger on Order__c (before insert, before update,
                                  before delete, after insert,
                                  after update, after delete,
                                  after undelete) {
    if (Trigger.isAfter && Trigger.isInsert) {
        //OrderTriggerHandler.share(Trigger.newMap);
    }
    else if (Trigger.isAfter && Trigger.isUpdate) {
        //OrderTriggerHandler.share(Trigger.newMap);
    }
}