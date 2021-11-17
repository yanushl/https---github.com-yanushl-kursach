public with sharing class AfterCalculationHandler {
    
    @InvocableMethod(label='finish calculation')
    public static void finishCalculation(List<Calculation__c> lst){
        List<Id> specificationIds=new List<Id>();
        Integer index=2;
        for (Calculation__c item : lst) {
            specificationIds.add(item.Specification__c);
        }

        List<Specification__c> specifications=
            [SELECT Price__c, Specification_Satus__c,Project__c
            FROM Specification__c
            WHERE Id IN :specificationIds];
        for (Calculation__c calc : lst) {
            for (Specification__c sp : specifications) {
                if (calc.Specification__c==sp.Id) {
                    sp.Price__c=calc.Price__c;
                    sp.Specification_Satus__c=
                        PickListValueHandler.getPickListSpecificationStatus().get(index);
                }
            }
        }  
        update specifications; 


        List<Id> projectIds=new List<Id>();
        for (Specification__c item : specifications) {
            projectIds.add(item.Project__c);
        }
        List<Project__c> projects=[SELECT Id,Project_Status__c
            FROM Project__c
            WHERE Id IN :projectIds];
        List<Specification__c> sps=[SELECT Id,Specification_Satus__c,Project__c
            FROM Specification__c
            WHERE Project__c IN :projectIds];    
        Integer i=1;
        
        for (Project__c item:projects) {
            for (Specification__c sp : sps) {
                if (item.Id==sp.Project__c &&sp.Specification_Satus__c!=
                PickListValueHandler.getPickListSpecificationStatus().get(index)) {
                    i--;    
                }
            }
            
           /* for (Specification__c sp:) {
                if (item.Id==sp.Project__c && sp.Specification_Satus__c!=
                PickListValueHandler.getPickListSpecificationStatus().get(index)) {
                    i--;
                }
            }*/
            if (i==1) {
                item.Project_Status__c=
                    PickListValueHandler.getPickListProjectStatus().get(index);
            }
            i=1;
        }
        update projects;
    }
}
