@RestResource(urlMapping = '/api/Event__c/*')
global with sharing class EventDetailRestService {
    @HTTPGet
    global static Event__c doGetEvt(){
        RestRequest req = RestContext.request;
        RestResponse resp = RestContext.response;
        String evtId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1); 
        Event__c result = [Select Id, Name, Address_Book__r.Name, Event_Organizer__r.Name, Live__c, Recurring__c, Start_Date_Time__c, End_Date_Time__c from Event__c where Id =: evtId];
        return result;
    }
}