/*      
    *   @Description    :    Types of Keywords with implementation (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    02/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class KeywordsInApex {

    private static final Integer num = 10;
    private static final Double pi = 3.14;

    /* 
        *    @Description    :      Implement final keyword 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    // Final -> It is used for define a valus as an constant , we can not do change valus of a final variable after initialized it.

    public void finalKeyword() {
        Integer num2 = 50;
        Double radius = 50.0;
        System.debug('Are of Circle = ' + KeywordsInApex.pi * radius * radius);
        System.debug('Instance variable = ' + KeywordsInApex.num);
        //num = 20;  We can not change the value of final keyword because it is a constant.
        System.debug('Local variable = ' + num2);
    }

    /* 
        *    @Description    :      Implement this keyword 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    // this -> It is used for reference to instance variable and for access current class methods and constructor

    Boolean bool = true;
    public void thisKeyword() {
        Boolean bool = false;
        System.debug('Using this keyword -> ' + this.bool);
        System.debug('Without using this keyword -> ' + bool);
    }
}