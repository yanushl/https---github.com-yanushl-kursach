public with sharing class OrderTriggerHandler {
    public static void share(Map<Id,Order__c> orders){
        List<Order__Share> sharings= new List<Order__Share>();
        List<Id> ids=new List<Id>();
        for (Order__c item : orders.values()) {
            ids.add(item.Request__c);
        }
        List<Request__c> requests=
            [SELECT OwnerId FROM Request__c WHERE Id IN :ids];   
        for (Order__c item : orders.values()) { 

            for (Request__c variable : requests) {
                if (item.Request__c==variable.Id) {
                    Order__Share sharingObject= new Order__Share();
                    sharingObject.ParentId=item.Id;
    System.debug('o');
                    sharingObject.UserOrGroupId=variable.OwnerId;
                    sharingObject.AccessLevel='Read';
                    sharings.add(sharingObject);
                }
            }
        }
        insert sharings;
    }
}
