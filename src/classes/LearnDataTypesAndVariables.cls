/*      
        @Description    :    Understand Datatypes in Apex And also Practise on Methods of Date Class , DateTime Class and String Class in Apex.

        @Created By     :    Shubham Kumar
        
        @Created Date   :    25/06/2022

        @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
                                V1.1  -  Modified  -  27/06/2022 By Shubham Kumar  -  Modified

 */

public with sharing class LearnDataTypesAndVariables {

     /* 
            Description     :       Learn about DataTypes in Apex

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  25/06/2022  - Shubham Kumar  - Used for Practise

    */
    public static void dataTypePractice() {
        // 1.Integer -> It is used for store Integer number.
        Integer radius = 10;
        System.debug('The Area Of Circle Is ' + 3.14*radius*radius);

        // Decimal -> It is used for store any floating point value.
        Decimal percentage = 75.5;
        System.debug('You Are First Devision and your marks is: ' + percentage);

        // Double -> It is used for store large floating point numbers as compare to Decimal.
        Double d = 3.14150;
        System.debug('Double is ' + d);

        // String -> It is used for store sequence of characters in a single variable.
        String name = 'Shubham Kumar';
        String password = 'shubham281202';
        System.debug('UserName Is ' + name);

        // Long -> It is used for store large amount of data.
        Long l = 2147483648L;
        System.debug('Long number is ' + l);

        // Boolean -> It is used for store only two values 'true' and 'false' and NULL also. 
        Boolean indiaIsWinner = true;
        Boolean pakIsWinner = false;
        System.debug('India is Winner Or Not ? ' + indiaIsWinner);

        // ID -> It is used to set the id as 15 character values.
        ID id='00300000003T2PGAA0';
        System.debug('ID is ' + id);

        // Object 
        Object obj = 10;
        // Cast the object to an integer.
        Integer obj1 = (Integer)obj;
        System.assertEquals(10, obj1);
        System.debug('Object change in Integer ' + obj1);

        // Blob -> It is used for store collection of binary data.
        String str = 'This is Blob datatype';
        Blob b = Blob.valueOf(str);
        String s1 = b.toString();
        System.debug(b);

        // Date -> It is used for display current date or date.
        Date d1;
        d1 = Date.today();
        System.debug('Current Date is ' + d1);

        // DateTime -> It is used for display the date and time.
        DateTime dt;
        dt = DateTime.now(); 
        System.debug('Current Date and time is ' + dt);
    }

    /* 
            Description     :       In this method we use Date class methods

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  25/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void dateClassMethods() {

        System.debug('-------------addDays()-----------');

        // addDays(additionaldays)
        Date myDate1 = Date.newInstance(1960, 2, 17);
        Date newDate1 = mydate1.addDays(2);
        System.debug('Let suppose Current Date ' + myDate1);
        System.debug('After adding 2 days ' + newDate1);

        System.debug('-------------addMonths()-----------');

        // addMonths(additionalMonths)
        date myDate2 = date.newInstance(1990, 11, 21);
        date newDate2 = myDate2.addMonths(3);
        date expectedDate2 = date.newInstance(1991, 2, 21);
        System.assertEquals(expectedDate2, newDate2);
        System.debug('Let suppose Current Date ' + myDate2);
        System.debug('After adding 3 months ' + newDate2);
        System.debug('We want to get Expected Date ' + expectedDate2);

        System.debug('-------------addYear()-----------');

        // addYear(additionalYear)
        date myDate3 = date.newInstance(1983, 7, 15);
        date newDate3 = myDate3.addYears(2);
        date expectedDate3 = date.newInstance(1985, 7, 15);
        System.assertEquals(expectedDate3, newDate3);
        System.debug('Let suppose Current Date ' + myDate3);
        System.debug('After adding 2 years ' + newDate3);
        System.debug('We want to get Expected Date ' + expectedDate3);

        System.debug('-------------day()-----------');

        // day()
        date myDate4 = date.newInstance(1989, 4, 21);
        Integer day1 = myDate4.day();
        System.assertEquals(21, day1);
        System.debug('Let suppose Date is ' + myDate4);
        System.debug('Number Of Days ' + day1);

        System.debug('-------------dayOfYear()-----------');

        // dayOfYear()
        date myDate5 = date.newInstance(1998, 10, 21);
        Integer day2 = myDate5.dayOfYear();
        System.assertEquals(294, day2);
        System.debug('Let Suppose Date is ' + myDate5);
        System.debug('Number Of Days ' + day2);

        System.debug('-------------daysBetween()-----------');

        // daysBetween(secondDate)
        Date startDate = Date.newInstance(2008, 1, 1);
        Date dueDate = Date.newInstance(2008, 1, 30);
        Integer numberDaysDue = startDate.daysBetween(dueDate);
        System.debug(numberDaysDue);

        System.debug('-------------toStartOfMonth()-----------');

        // toStartOfMonth()
        date myDate6 = date.newInstance(1987, 12, 17);
        date firstDate = myDate6.toStartOfMonth();
        date expectedDate4 = date.newInstance(1987, 12, 1);
        System.assertEquals(expectedDate4, firstDate);
        System.debug('Let Suppose date is ' + myDate6);
        System.debug('Starting date of month is ' + firstDate);

        System.debug('-------------isLeapYear(Year)-----------');

        // isLeapYear(Year)
        system.assert(Date.isLeapYear(2004));
        System.debug('The year is Leap Year: ' + Date.isLeapYear(2004));

        System.debug('-------------parse(stringDate)-----------');

        // parse(stringDate)
        date mydate7 = date.parse('12/27/2009');
        System.debug('The Given Date Is: ' + myDate7);

        System.debug('-------------toStartOfWeek()-----------');

        // toStartOfWeek()
        Date myDate8 = Date.today();
        Date weekStart = myDate8.toStartofWeek();
        System.debug('The Current Date Is: ' + myDate8);
        System.debug('Weak Start From: ' + weekStart);

        System.debug('-------------year()-----------');

        // year()
        date myDate9 = date.newInstance(1988, 12, 17);
        system.assertEquals(1988, myDate9.year());
        System.debug('Let suppose Date is: ' + myDate9);
        System.debug('The Year Is: ' + myDate9.year());

    }

     /* 
            Description     :       In this method we use DateTime class methods

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  25/06/2022  - Shubham Kumar  - Used for Practise
            
    */

    public static void DateTimeClassMethods() {

        System.debug('------------addDays()--------------');
        // addDays(additionalDays)
        Datetime myDateTime1 = Datetime.newInstance(1960, 2, 17);
        Datetime newDateTime1 = myDateTime1.addDays(2);
        Datetime expected1 = Datetime.newInstance(1960, 2, 19);
        System.assertEquals(expected1, newDateTime1);
        System.debug('Let suppose current DateTime is ' + myDateTime1);
        System.debug('After Adding 2 Days ' + newDAteTime1);

        System.debug('------------addHours()--------------');

        // addHours(additionalHours)
        DateTime myDateTime2 = DateTime.newInstance(1997, 1, 31, 7, 8, 16);
        DateTime newDateTime2 = myDateTime2.addHours(3);
        DateTime expected2 = DateTime.newInstance(1997, 1, 31, 10, 8, 16);
        System.assertEquals(expected2, newDateTime2);
        System.debug('Let suppose current DateTime is ' + myDateTime2);
        System.debug('After Adding 3 Hours ' + newDateTime2);

        System.debug('------------addMonths()--------------');

        //addMonths(additionalMonths)
        DateTime myDateTime3 = DateTime.newInstance(2000, 7, 7, 7, 8, 12);
        DateTime newDateTime3 = myDateTime3.addMonths(1);
        DateTime expected3 = DateTime.newInstance(2000, 8, 7, 7, 8, 12);
        System.assertEquals(expected3, newDateTime3);
        System.debug('Let suppose Current DateTime is ' + myDateTime3);
        System.debug('After Adding 1 month ' + newDateTime3);

        System.debug('------------addYears()--------------');

        //addYears(additionalYears)
        DateTime myDateTime4 = DateTime.newInstance(2009, 12, 17, 13, 6, 6);
        DateTime newDateTime4 = myDateTime4.addYears(1);
        DateTime expected4 = DateTime.newInstance(2010, 12, 17, 13, 6, 6);
        System.assertEquals(expected4, newDateTime4);
        System.debug('Let suppose current DateTime is ' + myDateTime4);
        System.debug('After Adding 1 year ' + newDateTime4);

        System.debug('------------hours()--------------');

        // hours()
        DateTime myDateTime5 = DateTime.newInstance(1998, 11, 21, 3, 3, 3);
        System.assertEquals(3 , myDateTime5.hour());
        System.debug(myDateTime5);

        System.debug('------------newInstance(date,time)--------------');

        Date myDate1 = Date.newInstance(2011, 11, 18);
        Time myTime1 = Time.newInstance(3, 3, 3, 0);
        DateTime dt1 = DateTime.newInstance(myDate1, myTime1);
        DateTime expected5 = DateTime.newInstance(2011, 11, 18, 3, 3, 3);
        System.assertEquals(expected5, dt1);
        System.debug('Let suppose Date is ' + myDate1);
        System.debug('Let suppose Time is ' + myTime1);
        System.debug('After combine Date and Time ' + dt1);

        System.debug('------------newInstance(Year,month,day,hour,minute,second)--------------');

        Datetime myDate2 = Datetime.newInstance(2008, 12, 1, 12, 30, 2);
        System.debug('Year,month,day,hour,minute,second ' + myDate2);

        System.debug('------------isSameDay(dateToCompare)--------------');

        datetime myDate3 = datetime.now();
        datetime dueDate1 = datetime.newInstance(2008, 1, 30);
        boolean dueNow = myDate3.isSameDay(dueDate1);
        System.debug('Current Date is: ' + myDate3);
        System.debug('DueDate is: ' + dueDate1);
        System.debug('After using isSameDay method: ' + dueNow);

        System.debug('------------year()--------------');

        // year()
        DateTime dt2 = DateTime.newInstance(2012, 1, 26, 5, 2, 4);
        System.assertEquals(2012, dt2.year());
        System.debug('Let suppose Current DateTime Is: ' + dt2);
        System.debug('After using year method we got: ' + dt2.year());

        System.debug('------------valueOf(fieldValue)--------------');

        // valueOf(fieldValue)
        List<AccountHistory> ahlist = [SELECT Field,OldValue,NewValue FROM AccountHistory];
        for(AccountHistory ah : ahlist) {
            System.debug('Field: ' + ah.Field);
            if (ah.field == 'MyDatetime__c') {
                Datetime oldValue = Datetime.valueOf(ah.OldValue);
                Datetime newValue = Datetime.valueOf(ah.NewValue);
            }
        }
        System.debug(ahlist);

    }

     /* 
            Description     :       In this method we use String class methods

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  26/06/2022  - Shubham Kumar  - Used for Practise
            
    */

    public static void StringClassMethods() {

        System.debug('------------abbreviate(maxWidth)-------------');

        // abbreviate(maxWidth)
        String s1 = 'Hello Maximillian';
        String s2 = s1.abbreviate(8);
        System.assertEquals('Hello...', s2);
        System.assertEquals(8, s2.length());
        System.debug(s2);

        System.debug('--------------abbreviate(maxWidth,offset)---------');

        // abbreviate(maxWidth,offset)
        String s3 = 'Hello Maximillian';
        // Start at M
        String s4 = s3.abbreviate(9,6);
        System.assertEquals('...Max...', s4);
        System.assertEquals(9, s4.length());
        System.debug('The String is: ' + s3);
        System.debug('After using Method: ' + s4);

        System.debug('--------------capitalize()---------');

        // capitalize()
        String s5 = 'hello maximillian';
        String s6 = s5.capitalize();
        System.assertEquals('Hello maximillian', s6);
        System.debug('The String Is: ' + s5);
        System.debug('After using method: ' + s6);

        System.debug('--------------center(size)---------');

        // center(size)
        String s7 = 'hello';
        String s8 = s7.center(9);
        System.assertEquals('  hello  ', s8);
        System.debug('The String Is: ' + s7);
        System.debug('After using metod: ' + s8);

        System.debug('------------center(size,paddingString)-----------');

        // center(size,paddingString)
        String s9 = 'hello';
        String s10 = s9.center(9, '-');
        System.assertEquals('--hello--', s10);
        System.debug('The String Is: ' + s9);
        System.debug('After using method: ' + s10);

        System.debug('------------charAt(index)-----------');

        // charAt(index)
        String str1 = 'Ω is Omega.';
        System.assertEquals(937, str1.charAt(0));
        System.debug('The String Is: ' + str1);
        System.debug('After using method: ' + str1.charAt(0));

        System.debug('------------compareTo(secondString)-----------');

        // compareTo(secondString)
        String myString1 = 'abcde';
        String myString2 = 'abcd';
        Integer result1 = myString1.compareTo(myString2);
        System.assertEquals(result1, 1);
        System.debug('After compare both Strings: ' + result1);

        System.debug('------------contains(subString)-----------');

        // contains(subString)
        String myString3 = 'abcde';
        String myString4 = 'abcd';
        Boolean result2 = myString3.contains(myString4);
        System.assertEquals(result2, true);
        System.debug('First String Is: ' + myString3);
        System.debug('Second String Is: ' + myString4);
        System.debug('After checking second string exist or not: ' + result2);

        System.debug('------------containsIgnoreCase(subString)-----------');

        // containsIgnoreCase(subString)
        String s11 = 'hello';
        Boolean b1 = s11.containsIgnoreCase('HE');
        System.assertEquals(true, b1); 
        System.debug('String Is: ' + s11);
        System.debug('After Using Method: ' + s11.containsIgnoreCase('HE'));

        System.debug('------------containsNone(inputstring)-----------');

        // containsNone(inputSting)
        String s12 = 'abcde';
        System.assert(s12.containsNone('fg'));
        System.debug('The String Is: ' + s12);
        System.debug('After using method: ' + s12.containsNone('fg'));

        System.debug('------------containsOnly(inputString)-----------');

        // containsOnly(inputString)
        String s13 = 'abba';
        String s14 = 'abba xyz';
        Boolean b2 = s13.containsOnly('abcd');
        System.assertEquals(true, b2);
        System.debug('First String Is: ' + s13);
        System.debug('Second String Is: ' + s14);
        System.debug('After using containsOnly method: ' + b2);

        System.debug('------------equals(secondString)-----------');

        // equals(secondString)
        String myString5 = 'abcde';
        String myString6 = 'abcd';
        Boolean result3 = myString5.equals(myString6);
        System.assertEquals(result3, false);
        System.debug('First String Is: ' + myString5);
        System.debug('Second String Is: ' + myString6);
        System.debug('After Checking Equals or Not: ' + result3);

        System.debug('------------equals(stringOrId)-----------');

        // equals(stringOrId)
        // Compare a string to an object containing a string
        Object obj1 = 'abc';
        String str2 = 'abc';
        Boolean result4 = str2.equals(obj1);
        System.assertEquals(true, result4);
        System.debug('Checking object and string are equals or not: ' + result4);

        // Compare a string to an object containing a number
        Integer obj2 = 100;
        Boolean result5 = str2.equals(obj2);
        System.assertEquals(false, result5);
        System.debug('Compare String to an Object: ' + result5);

        // Compare a string to an ID of the same length.
        // 15-character ID
        Id idValue15 = '001D000000Ju1zH';
        // 15-character ID string value
        String stringValue15 = '001D000000Ju1zH';
        Boolean result6 = stringValue15.equals(IdValue15);
        System.assertEquals(true, result6); 
        System.debug('Compare String to an Id: ' + result6);

        // Compare two equal ID values of different lengths:
        //  15-character ID and 18-character ID
        Id idValue18 = '001D000000Ju1zHIAR';
        Boolean result7 = stringValue15.equals(IdValue18);
        System.assertEquals(true, result7);
        System.debug('Compare two equal ID values of different lengths: ' + result7);

        System.debug('------------escapeJava()-----------');

        // escapeJave()
        // Input string contains quotation marks
        String s15 = 'Company: "Salesforce.com"';
        String escapedStr = s15.escapeJava();
        // Output string has the quotes escpaded
        System.assertEquals('Company: \\"Salesforce.com\\"', escapedStr);
        System.debug('After using escapeJava method: ' + escapedstr);       
    }

    /* 
            Description     :       Understand about variable declaration and Initialization , case sensitivity

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise
            
    */

    public static void learnAboutVariables() {
        // Variable declaration and Initialization
        Integer i1 = 0;
        String str;
        List<String> strList;
        Set<String> s;
        Map<ID, String> m;
        System.debug('The value of i= ' + i1);
        System.debug('Value of str= ' + str);

        Boolean x = null;
        Decimal d;
        System.debug('Value of x= ' + x);

        // Variable Scope
        Integer i2;
        {
        // Integer i;  This declaration is not allowed
        }

        for (Integer j = 0; j < 10; j++);
        for (Integer j = 0; j < 10; j++);

        // case insensitive
        Integer I=10;
        Integer i3=20;
        //Integer i;  This would be an error.
        System.debug('The value of capital I= ' + I);
        System.debug('The value of small i= ' + i3);
    }

    public static void learnAboutConstants() {
        final Integer PRIVATE_INT_CONST = 200;
        System.debug('Constant value is= ' + PRIVATE_INT_CONST);
        //PRIVATE_INT_CONST = PRIVATE_INT_CONST + 10; // it gives error at the time of change constant value.
        System.debug(PRIVATE_INT_CONST);
    }
}