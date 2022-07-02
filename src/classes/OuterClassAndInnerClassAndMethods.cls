/*      
    *   @Description    :    Learn about Outer and Inner class in apex

    *   @Created By     :    Shubham Kumar
        
    *   @Created Date   :    30/06/2022

    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
                                
 */
public with sharing class OuterClassAndInnerClassAndMethods {
    // Inner class
    public class MyInnerClass {
        public void add() {
            Integer x = 10;
            Integer y = 20;
            System.debug('Addition = ' + (x + y));
        }
    } 
    public void executeInnerClass() {
        MyInnerClass ic = new MyInnerClass();
        ic.add();
    }
    public static Integer clsVariable = 5;
    public void classVariables() {  
        System.debug('------------Final Variables--------------');  
        // Final Variables
        final Integer MY_INT; 
        final Integer i1 = 10;
        System.debug('Value of Final variable is = ' + i1);

        System.debug('--------------Static Variables------------');
        Integer no1 = 10;
        Integer no2 = 50;
        String str = 'Shubham';
        System.debug(str);
        System.debug(clsVariable);
    }

    /* 
        *    @Description     :       Call By Value Example in Apex 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  30/06/2022  - Shubham Kumar  - Used for Practise
        *
    */


    public void callByValue() {

        System.debug('---------------CallByValue Example----------------');

        String msg = 'Original value';
        System.debug('Before Calling Method Our Value Is -> ' + msg);
        processCallByValue(msg);
        System.debug('After Calling Method Our Value Is -> ' + msg);
    }
    
    public void processCallByValue(String s) {
        s = 'Modified value';
        System.debug('Inside CallByValue Method -> ' + s);
    }

    /* 
        *    @Description     :       Call By Reference Exaple in Apex 
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  30/06/2022  - Shubham Kumar  - Used for Practise
        *
    */

    public void callByReference() {
        System.debug('---------------CallByReference Example---------------');
        List<Integer> fillMe = new List<Integer>();  
        System.debug('Original list -> ' + fillMe);     
        reference(fillMe);  
        
        referenceNew(fillMe); 
        System.debug('After Calling Both the Methods second List -> ' + fillMe);   
    }
            
    public void reference(List<Integer> firstList) {
        firstList.add(70);
        firstList.add(68);
        firstList.add(75);
        firstList.add(80);
        firstList.add(82);
        System.debug('After Calling reference method First List -> ' + firstList);
    }    
        
    public void referenceNew(List<Integer> secondList) {
        secondList.add(10);
        secondList.add(20);
        secondList.add(30);
        secondList.add(40);
        secondList.add(50);
        System.debug('After Calling referenceNew Method Second List -> ' + secondList);
    }
}