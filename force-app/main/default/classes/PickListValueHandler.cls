public with sharing class PickListValueHandler {
    public static List<String> getPickListStatus(){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult = Order__c.Status__c.getDescribe();
         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry pickListVal : ple){
             pickListValuesList.add(pickListVal.getLabel());
         }     
         return pickListValuesList;
     }

     public static List<String> getPickListProjectStatus(){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult = Project__c.Project_Status__c.getDescribe();
         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry pickListVal : ple){
             pickListValuesList.add(pickListVal.getLabel());
         }     
         return pickListValuesList;
     }

     public static List<String> getPickListSpecificationStatus(){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult = 
         Specification__c.Specification_Satus__c.getDescribe();
         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry pickListVal : ple){
             pickListValuesList.add(pickListVal.getLabel());
         }     
         return pickListValuesList;
     }
}

