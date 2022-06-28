/*      
        @Description    :    Learn About Expressions and Operators

        @Created By     :    Shubham Kumar
        
        @Created Date   :    27/06/2022

        @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
                                

 */

public with sharing class LearnAboutExpressionsAndOperators {

     /* 
            Description     :       Learn about Expressions 

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise

    */
    public static void learnExpressions() {
        Integer sum = 2+2;
        System.debug('Evaluate Given Expression = ' + sum);

        Decimal dec = 5*5.0;
        System.debug('Evaluate Decimal Expression = ' + dec);

        String str = 'This Is Apex Expression';
        System.debug(str);

        Account[] aa = [SELECT Id, Name FROM Account WHERE Name ='Acme'];
        Integer i = [SELECT COUNT() FROM Contact WHERE LastName ='Weissman'];
        List<List<SObject>> searchList = [FIND 'map*' IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead];
        System.debug(searchList);
        
    }

    /* 
            Description     :       Learn about Operators in Apex 

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void learnAboutExpressionOperators() {
        Integer num1 = 20;
        Integer num2 = 10; 
        System.debug('num1 = ' + num1); 
        System.debug('num2 = ' + num2);    
        String str = 'Shubham';       // Here we used Assignment Operator
        System.debug('String = ' + str);

        num1 += num2;                 // Here we used Addition Assignment Operator it is consider as (num1 = num1+num2)
        System.debug('Addition = ' + num1);

        num1 *= num2;                 // Here we used Multiply Assignment Operator
        System.debug('Multiply = ' + num1);

        num1 -= num2;                 // Here we used Subtraction Assignment Operator
        System.debug('Subtraction = ' + num1);

        num1 /= num2;                 // Here we used Devision Assignment Operator
        System.debug('Devision = ' + num1);

        boolean x = true;
        boolean y = false;          // Here we used OR Assignment Operator
        x |= y;
        System.debug('OR Assignment Operator = ' + x);

        x &= y;                     // Here we used And Assignment Operator
        System.debug('And Assignment Operator = ' + x);

        Integer number1 = 10;
        Integer number2 = 2;
        number1 >>= number2;         // Here we used Betwise shift right signed Assignment operator
        System.debug('Betwise Right Shift Operator = ' + number1);

        number1 = 10;
        number1 <<= number2;         // Here we used Betwise shift left signed Assignment Operator
        System.debug('Betwise Left Shift Operator = ' + number1);

        number1 = 10;
        number1 >>>= number2;       // Here we used Betwise shift right unsigned Assignment Operator
        System.debug('Betwise Right Shift Unsigned Operator = ' + number1);

        Integer n1 = 10;
        Integer n2 = 20;
        Integer n3 = 30;
        Integer larger = n1 > n2 ? n1 : n2;     // Here we used Ternary Operator
        System.debug('Larger between 10 and 20 = ' + larger);

        // AND logical Operator
        System.debug('(10>20) && (30>20) = ' + (n1>n2 && n3>n2));
        System.debug('(10<20) && (30>20) = ' + (n1<n2 && n3>n2));
        System.debug('(10>20) && (30<20) = ' + (n1>n2 && n3<n2));
        System.debug('(10<20) && (30<20) = ' + (n1<n2 && n3<n2));

        // OR logical Operator
        System.debug('(10>20) OR (30>20) = ' + (n1>n2 || n3>n2));
        System.debug('(10<20) OR (30>20) = ' + (n1<n2 || n3>n2));
        System.debug('(10>20) OR (30<20) = ' + (n1>n2 || n3<n2));
        System.debug('(10<20) OR (30<20) = ' + (n1<n2 || n3<n2));

        System.debug('-------------Relational Operator-----------');

        // Relational Operator
        Integer[] arr1 = new Integer[]{10,20,30,40,50};
        Integer[] arr2 = new Integer[]{10,20,30,40};
        Integer[] arr3 = new Integer[]{50,40,30,20};
        String s1 = 'Apex';
        String s2 = 'APEX';
        Integer init1 = 20;
        Integer init2 = 50;

        System.debug('arr1 == arr2 ->' + (arr1 == arr2));
        System.debug('arr1 == arr3 ->' + (arr1 == arr3));
        System.debug('arr1 == null ->' + (arr1 == null));
        System.debug('arr1 != null ->' + (arr1 != null));
        System.debug('arr1 == arr2 ->' + (arr1 == arr2));
        System.debug('s1 == s2 ->' + (s1 == s2));

        System.debug('init1 <= init2 ->' + (init1 <= init2));
        System.debug('init1 >= init2 ->' + (init1 >= init2));
        System.debug('arr1 === arr2 ->' + (arr1 === arr2));
        System.debug('init1 != init2 ->' + (init1 != init2));

        System.debug('Post Increment Operator init1++ -> ' + init1++);
        System.debug('After using post increment operator -> ' + init1);

        System.debug('Pre Increment Operator ++init1 -> ' + ++init1);
        System.debug('Pre decrement Operator --init1 -> ' + --init1);


    }

     /* 
            Description     :       Learn about Safenavigation Operator 

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  28/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void safeNavigationOperator() {

        String str1;
        System.debug(str1?.toLowerCase());

        String name = [SELECT Name  FROM Account WHERE Name = 'Edge']?.Name;
        System.debug(name);    
    }

    public static void rulesOfConversion() {
        Long millsPerYear = 365L * 24L * 60L * 60L * 1000L;
        Long expectedValue = 31536000000L;
        System.assertEquals(millsPerYear, expectedValue);
        System.debug('MillsPerYear= ' + millsPerYear);
        System.debug('expectedValue = ' + expectedValue);

        // Integer to Decimal
        Integer num1 = 10;
        Decimal dec = Decimal.valueOf(num1);
        System.debug('After convert in decimal: ' + dec);
    }
}