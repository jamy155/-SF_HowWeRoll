@isTest
public with sharing class MaintenanceRequestHelperTest {
    // implement scheduled code here


    @testSetup
    static void setupData() {
        Vehicle__c vehicle = new Vehicle__c(
            Name = 'Test Vehicle Car',
            Maintenance_Cycle__c = 10);
        Vehicle__c vehicle2 = new Vehicle__c(
            Name = 'Test Vehicle Bike',
            Maintenance_Cycle__c = 30);
        insert new List<Vehicle__c>{vehicle, vehicle2};

        Product2 equipment = new Product2(
            Name = 'Test Equipment 1',
            Maintenance_Cycle__c = 10);
        Product2 equipment2 = new Product2(
            Name = 'Test Equipment 2',
            Maintenance_Cycle__c = 20);
        Product2 equipment3 = new Product2(
            Name = 'Test Equipment 3',
            Maintenance_Cycle__c = 50);
        insert new List<Product2>{equipment, equipment2, equipment3};

        
                Case MaintenanceRequest1 = new Case(
                    Vehicle__c = vehicle.Id,
                    Type = 'Routine Maintenance',
                    Subject = 'Test Maintenance Request ' + 1,
                    Date_Reported__c = Date.today(),
                    Status = 'New');

                Case MaintenanceRequest1 = new Case(
                    Vehicle__c = vehicle2.Id,
                    Type = 'Repair',
                    Subject = 'Test Maintenance Request ' + 2,
                    Date_Reported__c = Date.today(),
                    Status = 'New');

                insert new List<Case>{MaintenanceRequest1,MaintenanceRequest2};


        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);
        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment2.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);
        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment3.Id,
            Maintenance_Request__c = MaintenanceRequest1.Id);

        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);
        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment2.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);
        Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
            Equipment__c = equipment3.Id,
            Maintenance_Request__c = MaintenanceRequest2.Id);
            


        
    }
}