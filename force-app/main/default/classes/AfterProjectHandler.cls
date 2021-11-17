public with sharing class AfterProjectHandler {
    
    @InvocableMethod(label='finish consruction')
    public static void finishConstruction(List<Project__c> lst){
        List<Id> orderIds=new List<Id>();
        Integer indexOrderPickList=3, indexProjectPickList=1;
        for(Project__c item: lst){
            orderIds.add(item.Order__c);
        }
        //updateOrderStatuses(orderIds, indexOrderPickList);
        
        for (Project__c item : lst) {
            item.Project_Status__c=
            PickListValueHandler.getPickListProjectStatus().get(indexProjectPickList);
        }
        update lst;
        
        setCalculation(lst);
    }

    private static void setCalculation(List<Project__c> lst){
        List<Id> projectIds=new List<Id>();
        List<Calculation__c> calcs=new List<Calculation__c>();
        Integer index=0,index2=1;

        for(Project__c item: lst){
            projectIds.add(item.Id);
        }

        List<Specification__c> specifications = [SELECT Id, Project__c,Name
            , Specification_Satus__c, Count_Of_Material__c
            FROM Specification__c 
            WHERE Project__c IN :projectIds 
            AND Specification_Satus__c =
             :PickListValueHandler.getPickListSpecificationStatus().get(index)];

        for (Specification__c item : specifications) {
            item.Specification_Satus__c=
                PickListValueHandler.getPickListSpecificationStatus().get(index2);
            calcs.add(new Calculation__c(
                Name=item.Name
                ,Specification__c=item.Id
                ,Count_Of_Material__c=item.Count_Of_Material__c)
                );
        }
        update specifications;
        insert calcs;    
    }


    public static List<Order__c> updateOrderStatuses(List<Id> orderIds, Integer index){
        List<Order__c> orders=[SELECT Id,Name,Status__c 
            FROM Order__c 
            WHERE Id IN :orderIds];

        for(Order__c item:orders){
        item.Status__c=PickListValueHandler.getPickListStatus().get(index);
        }
        update orders;
        return orders;
    }
}
