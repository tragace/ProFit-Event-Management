@isTest
public with sharing class EventClassController_Test {
    static Id createTestEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Live__c = true;
        evt.Recurring__c = true;
        evt.Max_Seats__c = 10;
        evt.Start_Date_Time__c = datetime.newInstance(2021, 06, 27, 12, 0, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 06, 28, 12, 0, 0);
        insert evt;
        return evt.Id;
    }
    static Id createTestSpeaker(){
        Speaker__c spk = new Speaker__c();
        spk.Name = 'Test Speaker';
        insert spk;
        return spk.Id;
    }
    static Id createTestAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Event__c = createTestEvent();
        insert att;
        return att.Id;
    }
    @IsTest
    static void testSpeaker(){
        
        System.Test.startTest();
        String recId;
        Event_Speaker__c eS = new Event_Speaker__c();
        eS.Event__c = createTestEvent();
        eS.Speaker__c = createTestSpeaker();
        eS.Name = 'Test Name';
        Event_Speaker__c name;
        String str = '';
        insert eS;
        List<Event_Speaker__c> retrievedSpeaker = EventClassController.getSpeakers(eS.Event__c);
        name = retrievedSpeaker.get(0);
        System.Test.stopTest();
        System.assertEquals('Test Name',name.Name);
    }
    @IsTest
    static void testLocation(){
        System.Test.startTest();
        String recId = createTestEvent();
        Event__c evts = EventClassController.getLocationDetails(recId);
        System.Test.stopTest();
        System.assertEquals('Test Event',evts.Name);
    }
    @IsTest
    static void testAttendee(){
        System.Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Attendee__c = createTestAttendee();
        eA.Event__c = createTestEvent();
        eA.Name = 'Test Event';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = EventClassController.getAttendees(eA.Event__c);
        name = retrievedAttendee.get(0);
        System.Test.stopTest();
        System.assertEquals('Test Event', name.Name);
    }
}