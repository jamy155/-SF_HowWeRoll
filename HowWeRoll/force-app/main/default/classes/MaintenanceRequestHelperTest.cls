@isTest
public with sharing class MaintenanceRequestHelperTest {
    // implement scheduled code here


    @testSetup
    static void setupData() {
        Vehicle__c vehicle = new Vehicle__c(
            Name = 'Test Vehicle Car');
        Vehicle__c vehicle2 = new Vehicle__c(
            Name = 'Test Vehicle Bike');
        insert new List<Vehicle__c>{vehicle, vehicle2};

        Product2 equipment = new Product2(
            Name = 'Test Equipment 1',
            Maintenance_Cycle__c = 10,
        	Replacement_Part__c=true);
        Product2 equipment2 = new Product2(
            Name = 'Test Equipment 2',
            Maintenance_Cycle__c = 20,
        	Replacement_Part__c=true);
        Product2 equipment3 = new Product2(
            Name = 'Test Equipment 3',
            Maintenance_Cycle__c = 50,
        	Replacement_Part__c=true);
        insert new List<Product2>{equipment, equipment2, equipment3};

        
                Case MaintenanceRequest1 = new Case(
                    Vehicle__c = vehicle.Id,
                    Type = 'Routine Maintenance',
                    Subject = 'Test Maintenance Request ' + 1,
                    Date_Reported__c = Date.today(),
                    Origin='Phone',
                    Status = 'New');

                Case MaintenanceRequest2 = new Case(
                    Vehicle__c = vehicle2.Id,
                    Type = 'Repair',
                    Subject = 'Test Maintenance Request ' + 2,
                    Date_Reported__c = Date.today(),
                    Origin='Phone',
                    Status = 'New');

                insert new List<Case>{MaintenanceRequest1,MaintenanceRequest2};


        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);
        Equipment_Maintenance_Item__c emi2 = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment2.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);
        Equipment_Maintenance_Item__c emi3 = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment3.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);

        Equipment_Maintenance_Item__c emi4= new Equipment_Maintenance_Item__c(
            Equipment__c = equipment.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);
        Equipment_Maintenance_Item__c emi5 = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment2.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);
        Equipment_Maintenance_Item__c emi6 = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment3.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);

        insert new List<Equipment_Maintenance_Item__c>{emi, emi2, emi3, emi4, emi5, emi6};
            
    }

    @isTest
    static void testMaintenanceRequest(){

        Test.startTest();

        Map<Id, Case> closedCaseMap = new Map<Id, Case>([SELECT Id FROM Case WHERE (Type = 'Repair' OR Type = 'Routine Maintenance') AND Status != 'Closed']);
        for(Case c : closedCaseMap.values()){
            c.Status = 'Closed';
        }
        update closedCaseMap.values();
        Test.stopTest();


        Map<Id, Case> newMRs = new Map<Id, Case>([
            SELECT Type, Id, Status,Subject,Date_Due__c
            FROM Case 
            WHERE Type = 'Routine Maintenance' AND Status = 'New']);
            System.debug(newMRs);
            
        System.Assert.areEqual(2, closedCaseMap.values().size());
        System.Assert.areEqual(2, newMRs.values().size());
    }
}