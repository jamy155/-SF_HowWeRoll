public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts {


    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    
    public static List<Product2> getEquipment() { 

        List<Product2> equipment = new List<Product2>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(WAREHOUSE_URL);
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            for (Object result:results) {
                Map<String,Object> row = (Map<String,Object>) result;
                Product2 eq = new Product2( Replacement_Part__c = true,
                                            Cost__c = (Decimal) row.get('cost'),
                                            Current_Inventory__c = (Decimal) row.get('quantity'),
                                            Lifespan_Months__c = (Decimal) row.get('lifespan'),
                                            Maintenance_Cycle__c = (Decimal) row.get('maintenanceperiod'),
                                            Warehouse_SKU__c = (String) row.get('sku'),
                                            Name = (String) row.get('name'));
                equipment.add(eq);
            }
        }
        return equipment;
    }

    public void execute(QueueableContext context) {

        List<Product2> equipment = getEquipment();

        if (!equipment.isEmpty()) {
            upsert equipment Warehouse_SKU__c;
        }
    }

    
}