public class EventAttendeeTriggerHandler {
    
    public static void sendConfirmationEmail(List<Event_Attendee__c> newRecordList ) {
        
        Set<Id> attendeesIdsSet = new Set<Id>();
        Set<Id> eventIdsSet = new Set<Id>();
        
        for(Event_Attendee__c ea : newRecordList){
            attendeesIdsSet.add(ea.Attendee__c);
            eventIdsSet.add(ea.Event__c);
        }
        
        Map<Id,Attendee__c> attendeeMap = new Map<Id,Attendee__c>( 
            [Select Id, Name, Email__c From Attendee__c WHERE  Id IN : attendeesIdsSet]
        );
        
        Map<Id, Event__c > eventMap = new Map<Id, Event__c > ( [Select Id, Name, Start_Date_Time__c, Event_Organizer__c , Event_Organizer__r.Name,
                                                                Address_Book__c , Address_Book__r.Name, Address_Book__r.City__c,
                                                                Address_Book__r.State__c, Address_Book__r.Country__c,
                                                                Address_Book__r.Postal_Code__c, Address_Book__r.Street__c
                                                                FROM Event__c  WHERE ID IN: eventIdsSet]
                                                             );
        
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for(Event_Attendee__c ea : newRecordList){
            
            Attendee__c att = attendeeMap.get(ea.Attendee__c);
            Event__c evt = eventMap.get(ea.Event__c);
              
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setSubject('Pass for the '+evt.Name);
            List<String> toAddress = new List<String>();
            toAddress.add(att.Email__c);
            mail.setToAddresses( toAddress );
            mail.setSenderDisplayName(evt.Event_Organizer__r.Name);
            
            String locaton = 'https://www.google.com/maps/place/'+evt.Address_Book__r.Street__c+' '+evt.Address_Book__r.City__c+' '
                +evt.Address_Book__r.State__c+' '+
                evt.Address_Book__r.Country__c+' '+evt.Address_Book__r.Postal_Code__c;
            String hrefForLocation = '<a href="'+locaton+'"'+'target="_blank">Here</a>';
            String emailBody = 'Dear '+ att.Name + ',<br/><br/>'+
                'Thank you for registering for '+evt.Name+' which will be Organized on '+
                evt.Start_Date_Time__c+' & will be held in '+evt.Address_Book__r.Name
                +'.<br/>We are excited to have you,'+ 
                'see you in the event. <br/>'+
                'Find the Google Map Location for the Event '+hrefForLocation+'.<br/><br/><br/>'+
                'Thanks,<br/>'+evt.Event_Organizer__r.Name;
            
            mail.setHtmlBody(emailBody);
            emailList.add(mail);
            
        }
        
        try{
            
            List<Messaging.SendEmailResult> results =  Messaging.sendEmail(emailList, false); 
            for(Messaging.SendEmailResult email : results){
                System.debug(email.isSuccess());
                if(!email.isSuccess()){
                    List<Messaging.SendEmailError> errors = email.getErrors();
                }
            }  
        }catch(System.Exception ex){
            System.debug('get exception'+ex.getMessage());
        }
    }
}