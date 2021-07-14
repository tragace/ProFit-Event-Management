trigger EventAttendeeTriggerHandler on Event_Attendee__c (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        EventAttendeeTriggerHandler.sendConfirmationEmail(Trigger.new);
    }
}