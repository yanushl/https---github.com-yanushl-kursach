public with sharing class AfterSpecificationHandler {

    @InvocableMethod(label='finish specification')
    public static void finishSpecification(List<Specification__c> lst){
        List<Calculation__c> calcs=new List<Calculation__c>();
        Integer index=1;
        for (Specification__c item : lst) {
            item.Specification_Satus__c	=
                PickListValueHandler.getPickListSpecificationStatus().get(index);
            calcs.add(new Calculation__c(
                Name=item.Name
                ,Specification__c=item.Id
                ,Count_Of_Material__c=item.Count_Of_Material__c,
                Units__c=item.Units__c)
                );
        }
        update lst;
        insert calcs;    
    }
}
