@IsTest
private class BatchDeleteEventTest {
    @IsTest
    static void validateEventStatus(){
        Event__c evt = new Event__c();
        evt.Name = 'Event Sample';
        evt.Live__c = false;
        evt.Recurring__c = true;
        evt.Max_Seats__c = 10;
        evt.Start_Date_Time__c = datetime.newInstance(2020, 12, 21, 12, 0, 0);
        evt.End_Date_Time__c = datetime.newInstance(2020, 12, 22, 12, 0, 0);
        evt.Status__c = 'Published';
        insert evt;

        System.Test.startTest();
            DeleteEventBatch eventdelete = new DeleteEventBatch();
            database.executeBatch(eventdelete);
        System.Test.stopTest();

        Event__c createdEvent = [Select Status__c from Event__c where Id =: evt.Id];
        System.assertEquals('Deleted', createdEvent.Status__c);         

    }
}