/*      
    *   @Description    :    Method Overriding in Apex.(Child Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    30/06/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing class MethodOverridingChildClass extends MethodOverridingParentClass {
    public  override void display() {
        System.debug('This is child class'); 
    }
    
}