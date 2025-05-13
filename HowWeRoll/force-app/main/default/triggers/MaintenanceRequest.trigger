trigger MaintenanceRequest on Case (before insert, before update, after insert, after update, before delete, after delete, after undelete) {

    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter){
        MaintenanceRequestHelper.maintenanceRequest(Trigger.newMap);
    }

    
}