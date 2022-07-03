/*      
    *   @Description    :    Class-2 for implement PurchaseOrder Interface
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
// Another implementation of the interface for employees.

public with sharing class EmployeePurchaseOrder implements PurchaseOrder {

    /* 
        *    @Description    :      Implementation of abstract method 
        *
        *    @args           :       
        *
        *    @return         :       Double
        *
        *    @revision Log   :       V1.1  - Created  -  01/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public Double discount() {
        return .10;  // It’s worth it being an employee! 10% discount
    } 
}