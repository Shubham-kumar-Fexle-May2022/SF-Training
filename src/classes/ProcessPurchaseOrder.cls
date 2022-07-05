/*      
    *   @Description    :    class for calling object with interface
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class ProcessPurchaseOrder {
    // Constructor
    public ProcessPurchaseOrder() {
        PurchaseOrder order1 = new CustomerPurchaseOrder();
        // Customer Order
        processOrder(order1);

        // Employee Order
        PurchaseOrder order2 = new EmployeePurchaseOrder();
        processOrder(order2);

    }

    /* 
        *    @Description    :      Display the output 
        *
        *    @args           :       
        *
        *    @return         :       Double
        *
        *    @revision Log   :       V1.1  - Created  -  01/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public void processOrder(PurchaseOrder order) {
        System.debug('Check Discount: ' + order.discount());
    }
}