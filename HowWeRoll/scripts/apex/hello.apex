// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

List<Case> maintenanceRequest = new  List<Case>([
            SELECT id ,ProductId, Type, Vehicle__c, Status, Subject, Date_Reported__c,Date_Due__c ,ParentId	
            FROM Case 
            WHERE Type = 'Repair' OR Type = 'Routine Maintenance']);

List<Equipment_Maintenance_Item__c> items = new List<Equipment_Maintenance_Item__c>([SELECT Id,Equipment__c,Maintenance_Request__c FROM Equipment_Maintenance_Item__c ]);

List<Product2> equipment = new List<Product2>(); 
System.debug('Hello World!');
System.debug(maintenanceRequest);