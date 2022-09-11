/*      
    *   @Description    :    This class contains three different types of AuraEnabled method and 
                            We execute these methods in  our LWC component.(Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/09/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar   
 */

public with sharing class RenderMethodExample {

    // All the methods will return the value as a String.

    @AuraEnabled
    public static String getTextMethod1(){
        return 'METHOD-1';
    }
 
    @AuraEnabled
    public static String getTextMethod2(){
        return 'METHOD-2';
    }
 
    @AuraEnabled
    public static String getTextMethod3(){
        return 'METHOD-3';
    }
}