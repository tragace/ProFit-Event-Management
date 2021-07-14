trigger DuplicateSpeaker on Event_Speaker__c (before insert,before update) {
	if(trigger.IsBefore && (trigger.IsInsert || trigger.IsUpdate)){
		SpeakerDuplicate.checkDuplicate(Trigger.new);
	}
}