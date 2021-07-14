public with sharing class AttendeeEventsService {
    @AuraEnabled
    public static List<Event_Attendee__c> upcomingEvents(String attendeeId) {
      List<Event_Attendee__c> eventLists = [
        SELECT
          Id,
          Name,
          Event__c,
          Event__r.Address_Book__c,
          Event__r.Address_Book__r.Name,
          Event__r.Event_Organizer__c,
          Event__r.Event_Organizer__r.Name,
          Event__r.Name,
          Event__r.Start_Date_Time__c
        FROM Event_Attendee__c
        WHERE
          Attendee__c = :attendeeId
          AND Event__r.Start_Date_Time__c >= today
          AND Event__r.Live__c = true
      ];
      return eventLists;
    }
  
    @AuraEnabled
    public static List<Event_Attendee__c> pastEvents(String attendeeId) {
      List<Event_Attendee__c> eventLists = [
        SELECT
          Id,
          Name,
          Event__c,
          Event__r.Address_Book__c,
          Event__r.Address_Book__r.Name,
          Event__r.Event_Organizer__c,
          Event__r.Event_Organizer__r.Name,
          Event__r.Name,
          Event__r.Start_Date_Time__c
        FROM Event_Attendee__c
        WHERE Attendee__c = :attendeeId AND Event__r.Start_Date_Time__c < today
       
      ];
      return eventLists;
    }
  }