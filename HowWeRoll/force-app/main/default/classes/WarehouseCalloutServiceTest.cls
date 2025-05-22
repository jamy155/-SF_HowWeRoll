@IsTest
private class WarehouseCalloutServiceTest {
    
    
    @IsTest
    private static void testWarehouseSync(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        Test.startTest();
        List<Product2> equipment = WarehouseCalloutService.getEquipment();
        WarehouseCalloutService myQueueable = new WarehouseCalloutService();
        Id jobId = System.enqueueJob(myQueueable);
        Test.stopTest();

        System.Assert.areEqual(2,equipment.size() );
        System.assertEquals(true, jobID != null, 'Job ID should not be null');

    }
}