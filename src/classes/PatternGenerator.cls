public with sharing class PatternGenerator {

    //1. Creating Downward Star Pattern Program
    public static void createDownWardStarPattern() {
        for(Integer i=1; i<=5; i++) {
            String s=' ';
            for(Integer j=5; j>=i; j--) {
                s = s + '*'; 
            }
            System.debug(s);
        }
    }

    //2. Creating Left Triangle Star Programs
    public static void createLeftTriangleStarPattern() {
        for(Integer i = 1; i <= 5; i++) {
            String s = ' ';
            for(Integer j = 5; j > i; j--) {
                s = s + '_';
            }
            for(Integer k = 1; k <= i; k++) {
                s = s + '*';
            }
            System.debug(s);
        }
    }

    //3. Print Numeric Pattern In Descending Order
    public static void createNumericPattern() {
        for(Integer i=5; i>0; i--) {
            String s='  ';
  
            for(Integer j=5; j>=i; j--) {
                s=s+j;
            }
            System.debug(s);
        }
    }




    //4. Creating Left Triangle Pattern Program With Spaces
    public static void createLeftTrianglePattern() {
        Integer k=6;
        for(Integer i=1; i<=9; i++) {

            if(i<=5) {
                k--;
            } 
            else {
                k++;
            }
            String s='  ';
            for(Integer j=1; j<=5; j++) {

                if(j>=k) {
                    s = s + '*';
                }
                else {
                    s = s + '_';
                }
            } 
            System.debug(s); 
        }         
    }

    //5. Crete Down Triangle Pattern
    public static void createDownTrianglePattern() {
        Boolean b=true;
        for(Integer i=1; i<=5; i++) {

            String s='  ';
            for(Integer j=1; j<=9; j++) {

                if(i>=2 && i<=4){if(j>=1+i && j<=9-i){b=false;}else{b=true;}}else{b=true;}
            
                if(j>=i && j<=10-i && b) {

                    s = s + 'x';
                }
                else {

                    s = s + '_';
                }
            } 
            System.debug(s);
        } 
    }
}