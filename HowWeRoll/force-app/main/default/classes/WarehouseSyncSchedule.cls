public with sharing class WarehouseSyncSchedule implements Schedulable {
    // implement scheduled code here

        public void execute(SchedulableContext sc){
            WarehouseCalloutService equipmentUpdate = new WarehouseCalloutService();
            String jobID = System.enqueueJob(equipmentUpdate);
            system.debug('job id: ' + jobID);
        }
}