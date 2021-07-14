public with sharing class ErrorLogProFit {
    public static void createErrorLog(Datetime logdatetime, String logdetails, String pname) {
        Error_Log__c err = new Error_Log__c();
        err.Process_Name__c = pname;
        err.Log_Date_Time__c = logdatetime;
        err.Log_Details__c = logdetails;

        insert err;
    }
}