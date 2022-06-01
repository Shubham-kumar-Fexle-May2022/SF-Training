public class Stationery {
    public void BookName(String Name) {
        system.debug('The Book Name is: ' + Name);
    }
    
    public void BookPrice(Integer Price) {
        system.debug('The Price of book After 15% Discount is: ' + (Price - ((Price * 15)/100)));
    }
    
    public void BookWriter(String Writer) {
        system.debug('The Writer is: Mr.' + Writer);
    }

}