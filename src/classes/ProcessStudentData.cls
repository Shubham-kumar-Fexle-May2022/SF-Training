/*      
    *   @Description    :    Class for uses get & set prpeties
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class ProcessStudentData {
    public processStudentData(){
		
		//Getter method
		Student__c st = StudentDataProvider.stData;
	}
	
	public void saveStudentData(){
		Student__c s1;
		Student__c studentData = s1;
		//Setter Method
		StudentDataProvider.stData = s1;
		
	}
}