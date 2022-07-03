/*      
    *   @Description    :    Class-1 for implements PurchaseOrder Interface
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
// One implementation of the interface for customers.

public with sharing class CustomerPurchaseOrder implements  PurchaseOrder {

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
        return .05;  // Flat 5% discount
    }
}