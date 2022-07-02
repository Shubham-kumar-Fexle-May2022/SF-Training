/*      
    *   @Description    :    Understand the concept of Method Overloading and Constructor in Apex.
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    30/06/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class MethodOverloadingAndConstructor {

    private static final Integer defaultSize = 10;

    Integer size;

    /* 
        *    @Description     :      Constructor/Constructor Overloading in Apex 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  29/06/2022  - Shubham Kumar  - Used for Practise
        *
    */

    // Default Constructor (Without Parameter)

    public MethodOverloadingAndConstructor() {
        System.debug('The dafault size is -> ' + defaultSize);
    }

    // Parameterized Constructor (With Paramater)

    public MethodOverloadingAndConstructor(Integer ObjectSize) {
        size = ObjectSize;      // Initialization of class variable using Constructor
        System.debug(size);
    }

    /* 
        *    @Description     :      Method Overloading in Apex 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  30/06/2022  - Shubham Kumar  - Used for Practise
        *
    */



    public void methodOverloading() {
        Integer height = 10, width = 20;
        System.debug('Area Of Rectangle = ' + (height*width));
    }
    public void methodOverloading(Integer num) {
        if (num<=0) {
            System.debug(num + ' is Negative');
        } else {
            System.debug(num + ' is Positive');
        }
    } 
    public void methodOverloading(String str) {
        Integer strLength = str.length();
        System.debug('You entered -> ' + str);
        System.debug('Length of ' + str + 'is -> ' + strLength);

    }   
}