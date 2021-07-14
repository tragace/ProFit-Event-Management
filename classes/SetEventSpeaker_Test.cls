@isTest
private class SetEventSpeaker_Test {
    
    Static Id createTestRecordID(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Live__c = true;
        evt.Start_Date_Time__c = datetime.newInstance(2021, 6, 21, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 6, 22, 20, 30, 0);
        insert evt;
        return evt.Id;
    }

        @IsTest
      Static void checkEventEspeaker(){
        System.Test.startTest();

        try{
        Event_Speaker__c eS = new Event_Speaker__c();
        //Field Names
        //Create a new data to object
        eS.Name = 'Test Event-Speaker';
        eS.Event__c = createTestRecordID();
        eS.Speaker__c = 'a080l00000BCp3bAAD';
        
        insert eS;
        

        Event_Speaker__c retrievedES = [Select Name from Event_Speaker__c where Name =: eS.Name];

        System.assertEquals('Test Event-Speaker',retrievedES.Name);
        }
        catch (Exception ex){
          System.Test.stopTest();
        }
      }

    
}