public without sharing class FinishProjectHandler {
    
    @InvocableMethod(label='finish project')
    public static void finishProject(List<Project__c> lst){
        Integer indexOrderPickList=3, indexProjectPickList=4;
        List<Id> orderIds=new List<Id>();
        for (Project__c item : lst) {
            orderIds.add(item.Order__c);
            item.Project_Status__c=
            PickListValueHandler.getPickListProjectStatus().get(indexProjectPickList);
            System.debug(item.Order__c);

        }
        AfterProjectHandler.updateOrderStatuses(orderIds, indexOrderPickList);
        /*List<Order__c> orders=[SELECT Id,Name,Status__c 
            FROM Order__c 
            WHERE Id IN :orderIds];

        for(Order__c item:orders){
        item.Status__c=PickListValueHandler.getPickListStatus().get(indexOrderPickList);
        }
        update orders;*/


        update lst;
    }
}
