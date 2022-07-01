/*      
    *   @Description    :    Learn About Conditional statements and loops in Apex

    *   @Created By     :    Shubham Kumar
        
    *   @Created Date   :    29/06/2022

    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
                                
 */
public with sharing class ConditionalStatementsAndLoops {

     /* 
        *    @Description     :       Learn about Conditional Statements in Apex 

        *    @args           :       

        *    @return         :       void (Nohting)

        *    @revision Log   :       V1.1  - Created  -  29/06/2022  - Shubham Kumar  - Used for Practise

    */
    public static void conditionalStatements() {

        Integer x= -2, sign;
        // Your code
        if (x <= 0) {
            if (x == 0) {
                sign = 0; 
                System.debug(sign);
            } else  {
                sign = -1;
                System.debug(sign);
            }
        }

        System.debug('--------------Check Devision of student--------------');

        Integer percentage  = 75;
        if (percentage>=60) {
            System.debug('You are first devision: ' + percentage);
        } else if (percentage>=50) {
            System.debug('You are second devision: ' + percentage);
        } else if (percentage>=40) {
            System.debug('You are third devision: ' + percentage);
        } else {
            System.debug('Sorry!! You are fail');
        }


        System.debug('---------------Check Medal for Winner-------------');

        Integer place = 2;
        String medalColor;
        if (place == 1) {
            medalColor = 'gold';
            System.debug('You got-> ' + medalColor);
        } else if (place == 2) {
            medalColor = 'silver';
            System.debug('You got-> ' + medalColor);
        } else if (place == 3) {
            medalColor = 'bronze';
            System.debug('You got-> ' + medalColor);
        } else {
            medalColor = null;
            System.debug('You got-> ' + medalColor);
        }


        System.debug('-----------------Login Form--------------');

        String userName = 'shubham@fexle.com';
        String password = 'shubham123';

        if(userName == 'shubham@fexle.com' && password == 'shubham123') {
            System.debug('Login Successfull');
        }
        else {
            System.debug('Something Went Wrong!!');
        }
    }

     /* 
        *    Description     :       Learn about Loops in Apex 

        *    @args           :       

        *    @return         :       void (Nohting)

        *    @revision Log   :       V1.1  - Created  -  29/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void loopsInApex() {
        System.debug('----------------Traditional For loop---------------');
        // Traditional for loop
        for (Integer i = 0; i < 10; i++) {
            System.debug(i+1);
        }


        System.debug('-------------Retrive 5 Records From Account----------');

        List <Account> listOfAcc = [Select id, name from Account limit 5];
        for(Account acc : listOfAcc) {
            System.debug(acc);
        }

        System.debug('------------ List using while loop-----------');
        List <Integer> intList = new List<Integer>{10,20,30,40};
        Integer var1 = 0;
        while (var1 < intList.size()) {
            System.debug(intList[var1]);
            var1++;
        }

        System.debug('------------Query Account records iterating using while loop-----------');

        List <Account> listOfAcc2 = [Select id,name from Account limit 4];
        Integer index = 0;
        while(index < listOfAcc2.size()) {
            System.debug(listOfAcc2[index]);
            index++;
        }
        


        System.debug('---------------For loop with continue statement-----------');
        // For loop for printing reverse numbers.
        for(Integer count =5; count>0; count--) {
            if(count==3) {
                continue;
            }
            System.debug(count);
        }

        System.debug('---------------For loop with break statement-----------');
        // For loop with break
        for(Integer num=0; num<10; num++) {
            if(num==4) {
                break;
            }
            System.debug(num);
        }


        System.debug('----------------Do while loop(print 1 to 10 Numbers)-----------------');
        // Do while loop
        Integer count = 1;

        do {
            System.debug(count);
            count++;
        } while (count < 11);

        System.debug('-------------While loop---------------');
        System.debug('------Find Factorial------');
        // While loop
        Integer no = 5, factorial = 1;
        Integer step = 1;
        while(step <= no) {
            factorial = factorial * step;
            step++;
        }
        System.debug('The factorial of ' + no + ' is -> ' + factorial);


        System.debug('----------List or Set iteration for loop----------');
        Integer[] myInts = new Integer[]{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

        for (Integer i : myInts) {
            System.debug(i);
        }
    }

    public static void forLoopOnMap() {
        
        System.debug('---------------For loop On Map--------------');

        List <Account> accList = [Select Id, name from Account LIMIT 5];
        Map<Id,Account> mapOfAccounts = new Map<Id,Account>();
        for(Account acc : AccList) {
            mapOfAccounts.put(acc.Id,acc);
        } 
        System.debug('Map of Account -> ' + mapOfAccounts);

        for(Id accId : mapOfAccounts.keyset()) {
            System.debug(mapOfAccounts.get(accId));
        }
    }
}