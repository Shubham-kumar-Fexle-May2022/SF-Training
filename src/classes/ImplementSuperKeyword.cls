/*      
    *   @Description    :    Learn about super keyword .(Virtual class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    03/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing virtual class ImplementSuperKeyword {
    public String mySalutation;
    public String myFirstName;
    public String myLastName;

    // Default Constructor
    public ImplementSuperKeyword() {
        mySalutation = 'Mr.';
        myFirstName = 'Carl';
        myLastName = 'Vonderburg';
        printName();
    }

    // Parameterized Constructor
    public ImplementSuperKeyword(String salutation, String firstName, String lastName) {
        mySalutation = salutation;
        myFirstName = firstName;
        myLastName = lastName;
        printName();
    }

    // Method for printing.
    /* 
        *    @Description     :      print the output
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  03/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public virtual void printName() {

        System.debug('My name is ' + mySalutation + ' ' + myLastName);
    }
    
    // Method which return a String.
    /* 
        *    @Description     :      Return first name
        *
        *    @args           :       
        *
        *    @return         :       String
        *
        *    @revision Log   :       V1.1  - Created  -  03/07/2022  - Shubham Kumar  - Used for Practise
        *
    */
    public virtual String getFirstName() {
        return myFirstName;
    }
}