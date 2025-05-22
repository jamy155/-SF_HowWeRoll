@isTest
public with sharing class WarehouseSyncScheduleTest {
    
@isTest
    static void testWarehouseSync(){
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        WarehouseSyncSchedule mySchedule = new WarehouseSyncSchedule();
        String sch = '0 0 1 * * ? *';
        String jobID = System.schedule('TestjobName', sch, mySchedule);
        Test.stopTest();

        System.assertEquals(true,jobID != null, 'Job ID should not be null');


    }
        
}