@isTest
public with sharing class ErrorLogGenerator_Test {
    @IsTest
    static void testError(){
        
        System.Test.startTest();
        Datetime logdatetime = datetime.newInstance(2021, 6, 21, 19, 30, 0);
        String logdetails = 'Error Test';
        String pname = 'Test Error Name';
        ErrorLogProFit.createErrorLog(logdatetime, logdetails, pname);

        System.Test.stopTest();
        Error_Log__c eLog = [Select Id, Log_Date_Time__c,Log_Details__c,Process_Name__c from Error_Log__c];
        System.assertEquals('Test Error Name', eLog.Process_Name__c);
    }
}