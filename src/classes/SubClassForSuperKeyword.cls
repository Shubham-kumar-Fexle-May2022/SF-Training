/*      
    *   @Description    :    Sub class which inherit all the property & methods & constructor.
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    02/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class SubClassForSuperKeyword extends ImplementSuperKeyword {
    
    // Method of parent class which override in current class.

    public override void printName() {
        super.printName();
        System.debug('But you can call me ' + super.getFirstName());
    }

    // Sub class Default Constructor

    public SubClassForSuperKeyword() {
        super();
    }

    // Sub class Parameterized Constructor.

    public SubClassForSuperKeyword(String salutation, String firstName, String lastName) {
        super(salutation , firstName , lastName);
    }
}