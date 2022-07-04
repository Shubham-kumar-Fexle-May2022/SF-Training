/*      
    *   @Description    :    Get and Set Methods in Apex. (Parent Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class StudentDataProvider {
    //Way of Caching the Data
	public static Student__c stData{
		
		get{
			
			if(stData == null){
				
				//OneTime Run
				stData = [select id, name from Student__c where name != NULL];
			}
			return stData;
		}
		
		set{
			
			stData.Name = stData.Name + DateTime.now();
			system.debug('Check stData.Name ' + stData.Name);
		}
    }

    //public static Student__c stData{get;set;)
    //public static Student__c stData;
        
    @AUraEnabled
    public static Student__c getStData(){
            
        Student__c stLocal;
            
        if(stLocal == null){
                
            stLocal = [select id, name from Student__c where name != NULL];
        }
            
        return stLocal;
    }
}