/*      
    *   @Description    :    Static and Instance methods in apex in Apex. (Outer class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing class StaticAndInstanceMethods {

    public static boolean firstRun = true;

    /*      
    *   @Description    :    Understand instance methods and variable and Static block in Apex.(Inner Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    01/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
    // Using Instance methods and Variables
    class RGB {

        Integer red;
        Integer green;
        Integer blue;

        // Constructor of Inner class
        public RGB(Integer red, Integer green, Integer blue) {
            this.red = red;
            this.green = green;
            this.blue = blue;
            System.debug(red);
            System.debug(green);
            System.debug(blue);
        }
     }
    // Static initialization code is a block of code preceded with the keyword static.
   static Map<String, RGB> colorMap = new Map<String, RGB>();

    static {
        colorMap.put('red', new RGB(255, 0, 0));
        colorMap.put('cyan', new RGB(0, 255, 255));
        colorMap.put('magenta', new RGB(255, 0, 255));
    }

}