/*      
        @Description    :    Learn About collections in apex (List,Set,Map)

        @Created By     :    Shubham Kumar
        
        @Created Date   :    27/06/2022

        @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
                                

 */

public with sharing class CollectionsInApex {

    
 /* 
            Description     :       Understand about Lists In Apex

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void learnAboutlists() {

        // Create Empty list of String.
        List<String> myList1 = new List<String>();
        myList1.add('Shubham');
        myList1.add('Lokesh');
        myList1.add('Ram');
        myList1.add(1,'Raj');
        System.debug('List 1 Element -> ' + myList1);

        List<String> myList2 = new List<String>();
        myList2.add('India');
        myList2.add('USA');
        myList2.add('Punjab');
        System.debug('List 2 Element -> ' + myList2);
        System.debug('Add Raj at Index 1 -> ' + myList1);

        System.debug('----------------contains(listElement)------------');

        // contains(listElement)
        List<String> myStrings = new List<String>{'a', 'b'};
        Boolean result = myStrings.contains('z');
        System.assertEquals(false, result);
        System.debug('Elements in the list -> ' + myStrings);
        System.debug('List contains z or Not -> ' + result);

        System.debug('----------------equals(list2)------------');

        // equals(list2)
        Boolean res = myList1.equals(myList2);
        System.debug('List1 -> ' + myList1);
        System.debug('List2 -> ' + myList2);
        System.debug('Both of the strings are Equals or Not -> ' + res);

        System.debug('----------------getSObjectType()------------');

        // getSObjectType()

        // Create a generic sObject variable.
        SObject sObj = Database.query('SELECT Id FROM Account LIMIT 1');

        // Verify if that sObject  variable is an Account token.
        System.assertEquals(
        Account.sObjectType, sObj.getSObjectType());

        // Create a list of generic sObjects.
        List<sObject> q = new Account[]{};

        // Verify if the list of sObjects 
        // contains Account tokens.
        System.assertEquals(Account.sObjectType, q.getSObjectType());       
    }

     /* 
            Description     :       Learn About Sets In Apex 

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void learnAboutSets() {

        Set<String> myStringSet = new Set<String>();

        // Defines a new set with two elements
        Set<String> set1 = new Set<String>{'New York', 'Paris'};
        System.debug(set1);

        // Define a new set
        Set<Integer> mySet = new Set<Integer>();
        // Add two elements to the set
        mySet.add(1);
        mySet.add(3);
        // Assert that the set contains the integer value we added
        System.assert(mySet.contains(1)); 
        // Remove the integer value from the set
        mySet.remove(1);
        System.debug(mySet);

        // Define a new set that contains the
        // elements of the set created in the previous example
        Set<Integer> mySet2 = new Set<Integer>(mySet);
        // Assert that the set size equals 1
        // Note: The set from the previous example contains only one value
        System.assert(mySet2.size() == 1);
        System.debug('The size of mySet is: ' + mySet2);
    }

    /* 
            Description     :       Learn About Maps In Apex 

            @args           :       

            @return         :       void (Nohting)

            @revision Log   :       V1.1  - Created  -  27/06/2022  - Shubham Kumar  - Used for Practise

    */

    public static void learnAboutMaps() {
        Map<String, String> country_currencies = new Map<String, String>();
        Map<ID, Set<String>> m = new Map<ID, Set<String>>();

        Map<String, String> MyStrings = new Map<String, String>{'a' => 'b'.toUpperCase(), 'c' => 'd'.toUpperCase()};
        System.debug(myStrings);

        Map<Integer, String> m1 = new Map<Integer, String>(); // Define a new map
        m1.put(1, 'First entry');                  // Insert a new key-value pair in the map
        m1.put(2, 'Second entry');                  // Insert a new key-value pair in the map
        System.assert(m1.containsKey(1));  // Assert that the map contains a key
        String value = m1.get(2);               // Retrieve a value, given a particular key
        System.assertEquals('Second entry', value);
        Set<Integer> s = m1.keySet();      // Return a set that contains all of the keys in the map
        System.debug(m1);      

        System.debug('--------------size()-------------');

        Map<String, String> colorCodes1 = new Map<String, String>();

        colorCodes1.put('Red', 'FF0000');
        colorCodes1.put('Blue', '0000A0');

        Integer mSize = colorCodes1.size();
        system.assertEquals(2, mSize);
        System.debug('The size of map is: ' + msize);

        System.debug('--------------values()-------------');

        Map<String, String> colorCodes2 = new Map<String, String>();

        colorCodes2.put('Red', 'FF0000');
        colorCodes2.put('Blue', '0000A0');

        List<String> colors = new List<String>();
        colors = colorCodes2.values();
        System.debug('The values inside the Map are: ' +colors);
    }
}