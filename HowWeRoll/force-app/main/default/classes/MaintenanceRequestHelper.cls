public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders() {
        // TODO: Complete the method to update workorders
        
    }   
    
    public static void maintenanceRequest(Map<Id,Case> request){

        List<Case> newMaintenanceRequests = new List<Case>();
        Map<Case,Case> OldNewMRequest = new Map<Case,Case>();
        List<Equipment_Maintenance_Item__c> newEquipmentMaintenanceItems = new List<Equipment_Maintenance_Item__c>();

        List<Case> maintenanceRequests = new  List<Case>([
            SELECT Type, Vehicle__c, Status, Subject, Date_Reported__c,Date_Due__c, ProductId
            FROM Case 
            WHERE Id IN :request.keySet() AND Status = 'Closed' AND (Type = 'Repair' OR Type = 'Routine Maintenance')]);

        List<Equipment_Maintenance_Item__c> equipmentMaintenanceItems = new  List<Equipment_Maintenance_Item__c>([
            SELECT Maintenance_Request__c ,Equipment__c
            FROM Equipment_Maintenance_Item__c ]);

        System.debug('equipmentMaintenanceItems = '+equipmentMaintenanceItems.size());
        System.debug('equipmentMaintenanceItems = '+equipmentMaintenanceItems);

        Map<Id, Product2> equipmentList = new  Map<Id,Product2>([
            SELECT Id, Maintenance_Cycle__c
            FROM Product2 
            WHERE Maintenance_Cycle__c > 0 ]);

        
        for(Case req : maintenanceRequests){

                Case newMaintenanceRequest = new Case(
                    Status='New', 
                    Subject='New maintenance request', 
                    Type='Routine Maintenance', 
                    Vehicle__c=req.Vehicle__c, 
                    Date_Reported__c=System.today(),
                    Origin='Phone',
                    ProductId = req.ProductId
                    );

                OldNewMRequest.put(req,newMaintenanceRequest);  
                newMaintenanceRequests.add(newMaintenanceRequest);   
        }
        insert newMaintenanceRequests;


        for (Case req : OldNewMRequest.keySet()){

            for(Equipment_Maintenance_Item__c item : equipmentMaintenanceItems){
                if(item.Maintenance_Request__c == req.Id){
                    Integer days =  (Integer)equipmentList.get(item.Equipment__c).Maintenance_Cycle__c;
                    Case newMaintenanceRequest = OldNewMRequest.get(req);
                    newMaintenanceRequest.Date_Due__c = System.today().addDays(days);
                    Equipment_Maintenance_Item__c emi = new Equipment_Maintenance_Item__c(
                        Equipment__c = item.Equipment__c,
                        Maintenance_Request__c = OldNewMRequest.get(req).Id);
                        newEquipmentMaintenanceItems.add(emi);
                }
            }
        }
        update newMaintenanceRequests;
        insert newEquipmentMaintenanceItems;
    }

}