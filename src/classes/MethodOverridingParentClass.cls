/*      
    *   @Description    :    Method Overriding in Apex. (Parent Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    30/06/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing virtual class MethodOverridingParentClass {
    public virtual void display() {
        System.debug('This is Parent class');
        Integer length = 10 , width = 20;
        System.debug('Area of Rectangle (In Parent Class) = ' + (length * width));

    }
}