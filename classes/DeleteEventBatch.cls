public class DeleteEventBatch implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext batchContext){
        String Query = 'Select Id, Name From Event__c Where Live__c = false AND Status__c != \'Complete\' AND End_Date_Time__c < LAST_N_MONTHS:4';
        return Database.getQueryLocator(Query);
    }
    
    
    public void execute(Database.BatchableContext batchContext, List<Event__c> eventList ){
       
        List<Event__c> deletedEvtRecsList = new List<Event__c>();
        for(Event__c evt: eventList){
            evt.Status__c = 'Deleted';
            deletedEvtRecsList.add(evt);
            
        }
        update deletedEvtRecsList;
    }
    
    public void finish(Database.BatchableContext batchContext){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setSubject('Batch Processing Completed');
        List<String> toAddress = new List<String>();
        toAddress.add('kelalinea00@gmail.com');
        mail.setToAddresses( toAddress );
        mail.setSenderDisplayName('Event Deletion Email');
        
        mail.setHtmlBody('You have been deleted an event.');
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage> {mail};
        Messaging.sendEmail(emails);
    }
}