public with sharing class AddressBookZipTriggerHandler {
    @future(callout=true)
    public static void verifyZip(String addId){
        Address_Book__c add = [Select Id, Is_Zip_correct__c, State__c, Street__c, Postal_Code__c, City__c from Address_Book__c where Id = :addId];
        Http httpzip = new Http();
        HttpRequest reqzip = new HttpRequest();
        String addzip = 'https://us-zipcode.api.smartystreets.com/lookup?auth-id=6e617b2a-ab72-d0be-fa6a-661da48d1abd&auth-token=JzcKnWobVqRCKutfJXN8&city=&state=&zipcode='+ +add.Postal_Code__c;
        reqzip.setEndPoint(addzip);
        reqzip.setMethod('GET');
        HttpResponse respzip= new HttpResponse();
        respzip = httpzip.send(reqzip);

        try {
            if(respzip.getStatusCode() == 200)
            {
                List<Object> resultsZipList = (List<Object>)JSON.deserializeUntyped(respzip.getBody());
                    for(Object obj : resultsZipList){
                        Map<String, Object> results = (Map<String, Object>) obj;
                        List<Object> zipObject = (List<Object>) results.get('zipcodes');
                        if(zipObject!=null){
                            addressCall(addId);
                    }
                }
            }
        } 
        
        catch (Exception ex) {
            System.debug('Get Exception -- ' + ex.getMessage());
        }
    }
    
    public static void addressCall(String addId){
        Address_Book__c add = [Select Id, Is_Zip_correct__c, State__c, Street__c, Postal_Code__c, City__c from Address_Book__c where Id = :addId];
        Http httpst = new Http();
        HttpRequest reqst = new HttpRequest();
         String addst = 'https://us-street.api.smartystreets.com/street-address?auth-id=6e617b2a-ab72-d0be-fa6a-661da48d1abd&auth-token=JzcKnWobVqRCKutfJXN8'
         +'&street=' + EncodingUtil.urlEncode(add.Street__c, 'UTF-8') 
         +'&city='+ EncodingUtil.urlEncode(add.City__c, 'UTF-8')
         +'&state='+EncodingUtil.urlEncode(add.State__c, 'UTF-8');
         reqst.setEndPoint(addst);
         reqst.setMethod('GET');
        HttpResponse respst= new HttpResponse();
        respst = httpst.send(reqst); 
        try {
            if(respst.getStatusCode() == 200){
                String respstBody = respst.getBody();
                    if(respstBody.length()>2){
                        add.Is_Zip_correct__c = true;
                        add.Verified__c = true;
                    }else{
                        add.Is_Zip_correct__c = false;
                        add.Verified__c = false;
                    }
                    update add;
            }
        } 
        catch (Exception ex) {
            System.debug('Get Exception -- ' + ex.getMessage());
        }
    }
}