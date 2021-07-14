@isTest
public with sharing class AttendeeEventsController_Test {
    static Id createTestNewEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Start_Date_Time__c = datetime.newInstance(2021, 7, 21, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 7, 22, 19, 30, 0);
        evt.Live__c = true;
        evt.Max_Seats__c = 10;
        insert evt;
        return evt.Id;
    }
    static Id createTestOldEvent(){
        Event__c evt = new Event__c();
        evt.Name = 'Test Event';
        evt.Start_Date_Time__c = datetime.newInstance(2021, 3, 21, 19, 30, 0);
        evt.End_Date_Time__c = datetime.newInstance(2021, 3, 22, 19, 30, 0);
        evt.Live__c = false;
        evt.Max_Seats__c = 10;
        insert evt;
        return evt.Id;
    }
    static Id createTestNewAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Event__c = createTestNewEvent();
        insert att;
        return att.Id;
    }
    static Id createTestOldAttendee(){
        Attendee__c att = new Attendee__c();
        att.Name = 'Test Attendee';
        att.Event__c = createTestOldEvent();
        insert att;
        return att.Id;
    }
    @isTest
    static void testUpcomingEvents(){
        System.Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        Attendee__c att = new Attendee__c();
        eA.Event__c = createTestNewEvent();
        eA.Attendee__c = createTestNewAttendee();
        eA.Name = 'Test EA';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsService.upcomingEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        System.Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
    @isTest
    static void testPastEvents(){
        System.Test.startTest();
        Event_Attendee__c eA = new Event_Attendee__c();
        eA.Event__c = createTestOldEvent();
        eA.Attendee__c = createTestOldAttendee();
        eA.Name = 'Test EA';
        insert eA;
        Event_Attendee__c name;
        List<Event_Attendee__c> retrievedAttendee = AttendeeEventsService.pastEvents(eA.Attendee__c);
        name = retrievedAttendee.get(0);
        
        System.Test.stopTest();
        System.assertEquals('Test EA', name.Name);
    }
}