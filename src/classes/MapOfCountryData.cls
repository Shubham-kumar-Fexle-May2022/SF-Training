/*      
    *   @Description    :    Map of Country, States & cities. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    04/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */
public with sharing class MapOfCountryData {

    Map<String, Map<String, Map<String, List<String>>>> mapOfCountries = new Map<String, Map<String, Map<String, List<String>>>>();
    
    // Constructor
    public MapOfCountryData() {
        //Map of India
        Map<String, List<String>> mapOfStateWithCityOfIndia = new Map<String, List<String>>();
        mapOfStateWithCityOfIndia.put('Rajasthan', new List<String> {'Jaipur', 'Ajmer', 'Sikar', 'Bharatpur', 'Kota'});
        mapOfStateWithCityOfIndia.put('Uttar Pradesh', new List<String> {'Mathura', 'Kanpur', 'Gorakhpur', 'Hathras', 'Lucknow'});
        mapOfStateWithCityOfIndia.put('Maharashtra', new List<String> {'Ahmednagar', 'Akola', 'Aurangabad', 'Kohlapur', 'Chandrapur'});
        mapOfStateWithCityOfIndia.put('Uttarakhand', new List<String> {'Chamoli', 'Bageshwar', 'Haridwar', 'Pithoragarh', 'Uttarkashi'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfIndia = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfIndia.put('India', mapOfStateWithCityOfIndia);


        //Map of US
        Map<String, List<String>> mapOfStateWithCityOfUS = new Map<String, List<String>>();
        mapOfStateWithCityOfUS.put('South Dakota', new List<String> {'Grant-Deuel School District', 'Gregory School District', 'Greater Hoyt School District', 'Gettysburg School District'});
        mapOfStateWithCityOfUS.put('Colorado', new List<String> {'Big Sandy School District 100J', 'Creede School District', 'Monte Vista School District C-8', 'Hathras', 'Swink School District 33'});
        mapOfStateWithCityOfUS.put('Alaska', new List<String> {'Anchorage', 'Southeast Fairbanks Census Area', 'Nome Census Area', 'Sitka Borough'});
        mapOfStateWithCityOfUS.put('Florida', new List<String> {'Trinidad School District 1', 'Citrus County Schools', 'Sarasota County Schools', 'Gulf County Schools'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfUS = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfUS.put('United States of America', mapOfStateWithCityOfUS);


        //Map of Sri Lanka
        Map<String, List<String>> mapOfStateWithCityOfSriLanka = new Map<String, List<String>>();
        mapOfStateWithCityOfSriLanka.put('Anuradha Pura', new List<String> {'Anuradhapura East Electoral District', 'Mihintale Electoral District', 'Kekirawa Electoral District', 'Horowpothana Electoral District'});
        mapOfStateWithCityOfSriLanka.put('Southern Badulla', new List<String> {'Bogoda Wooden Bridge', 'Army Garrison Town', 'Namunukula Mountain Range','Southern Dambana'});
        mapOfStateWithCityOfSriLanka.put('Colombo', new List<String> {'Mattakkuliya', 'Lunupokuna', 'Mahawatte', 'Modera'});
        mapOfStateWithCityOfSriLanka.put('Kandy', new List<String> {'Poojapitiya', 'Thumpane', 'Udapalatha', 'Ududumbara'});

        Map<String, Map<String, List<String>>> mapOfCountryWithStateOfSriLanka = new Map<String, Map<String, List<String>>>();
        mapOfCountryWithStateOfSriLanka.put('Sri Lanka', mapOfStateWithCityOfSriLanka);


        mapOfCountries.put('IND', mapOfCountryWithStateOfIndia);
        mapOfCountries.put('USA', mapOfCountryWithStateOfUS);
        mapOfCountries.put('LKA', mapOfCountryWithStateOfSriLanka);

        // Printf Whole Map.
        //System.debug('mapOfCountries: ' + mapOfCountries);
        for(String key : mapOfCountries.keySet()) {
            System.debug(key + ' => ' + mapOfCountries.get(key));
        }
    
    }

    /* 
        *    @Description    :      Find city which length is greater than or equalto 9.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  05/07/2022  - Shubham Kumar  - Used for Practise
        *                                    Modified -  06/07/2022  - Shubham Kumar
    */

    public void findCityNamesOfSpecificLength() {
        for(String countryCode : mapOfCountries.keySet()) {
            for(String countryName : mapOfCountries.get(countryCode).keySet()) {
                for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                    for(String cityName : mapOfCountries.get(countryCode).get(countryName).get(stateName)) {
                        if(cityName.length()>=9) {
                            System.debug('Districts length is greaterthan 9 -> '+ cityName);
                        }
                    }
                }
            }
        }
    }

    
    /* 
        *    @Description    :      Find combination of counrty,state & city which start with S.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  06/07/2022  - Shubham Kumar  - Used for Practise
        *
    */

    List<String> listOfResults = new List<String>();

    public void findCombinationOfNameStartWithS() {
        for(String countryCode : mapOfCountries.keySet()) {
            for(String countryName : mapOfCountries.get(countryCode).keySet()) {
                if(countryName.charAt(0) == 83) {
                    for(String stateName : mapOfCountries.get(countryCode).get(countryName).keySet()) {
                        if(stateName.charAt(0) == 83) {
                            for(String cityName : mapOfCountries.get(countryCode).get(countryName).get(stateName)) {
                                if(cityName.charAt(0) == 83) {
                                    String str = countryCode + ' - ' + countryName + ' - ' + stateName + ' - ' + cityName;
                                    listOfResults.add(str);
                                }
                            }
                        }    
                    }
                }
            }
        }
        System.debug('Combination of Country, State & City which start with S -> ' + listOfResults);
    }
}