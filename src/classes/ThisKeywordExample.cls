/*      
    *   @Description    :    Implement this keyword
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    02/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class ThisKeywordExample {

    /* 
        *    @Description     :      Find Area of rectangle
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public void rectangleArea(Integer height , Integer width) {
        Integer area = height * width;
        System.debug('Area of rectangle = ' + area);
    }

    /* 
        *    @Description     :      Find area of square
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  02/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public void squareArea(Integer side) {
        Integer area = side * side;
        System.debug('Area of square = ' + area);

        // calling current class method using this keyword
        this.rectangleArea(10,20);
    }
}