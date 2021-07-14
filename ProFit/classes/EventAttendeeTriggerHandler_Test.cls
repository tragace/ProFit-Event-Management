@isTest
public class EventAttendeeTriggerHandler_Test {
    
    @testSetup
    public static void setupData(){
        
        Event_Orginizer__c  org = new Event_Orginizer__c (
            Name = 'Keith Alinea',
            Phone__c = '3645856',
            Email__c = 'keithalinea@gmail.com'
        );
        insert org;
        
        Event__c event = new Event__c(
            Name = 'Try Event',
            Event_Organizer__c  = org.Id,
            Event_Type__c = 'Virtual',
            Frequency__c  = 'Weekly',
            Max_Seats__c  = 56,
            Recurring__c = true,
            Live__c = true,
            Start_Date_Time__c = System.now(),
            End_Date_Time__c  = System.now().addDays(3)
        );
        insert event;
        Attendee__c att = new Attendee__c(
            Name = 'Michael Alinea',
            Email__c = 'testAttendee@gmail.com',
            Phone__c = '346457'
        );
        insert att;
        
        Event_Attendee__c evtAtt = new Event_Attendee__c(Event__c = event.Id, Attendee__c = att.Id);
        insert evtAtt;
    }
   
}