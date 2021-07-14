public with sharing class SpeakerDuplicate {
    public static void checkDuplicate(List<Event_Speaker__c> newSpeakerList) {
       try {
           for(Event_Speaker__c spk : newSpeakerList){
   
               Event__c evtDate = [Select Start_Date_Time__c,End_Date_Time__c from Event__c where Id = :spk.Event__c];
               List<Event_Speaker__c> spkCount = [Select Id,Event__c,Speaker__c from Event_Speaker__c where (Speaker__c = :spk.Speaker__c 
                                                                                 AND Event__c != :spk.Event__c)
                                                                                 AND((Event__r.Start_Date_Time__c <  :evtDate.End_Date_Time__c
                                                                                   AND Event__r.End_Date_Time__c     >  :evtDate.End_Date_Time__c) 
                                                                                   OR(Event__r.Start_Date_Time__c      <  :evtDate.Start_Date_Time__c
                                                                                    AND Event__r.End_Date_Time__c     >  :evtDate.Start_Date_Time__c)
                                                                                    OR(Event__r.Start_Date_Time__c >= :evtDate.Start_Date_Time__c
                                                                                    AND Event__r.End_Date_Time__c <= :evtDate.End_Date_Time__c))  ];                                                       
               
                if(spkCount.size()>0){
                    spk.Speaker__c.addError('The Speaker has an existing event already.');
                }
               
           }
       } catch (Exception ex) {
           System.debug('Exception -- ' + ex.getMessage());
       }
    }
}