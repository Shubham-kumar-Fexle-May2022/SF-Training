/*      
    *   @Description    :    Map Data manipulation using DML.(Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    11/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                        V1.1  - Modified -   14/07/2022    
 */

public with sharing class CountryStateDistrictMapDataManipulation {
    // Global Map
    Map<String, Map<String, List<String>>> mapOfCountryWithStateAndDistrict = new Map<String, Map<String, List<String>>>();
    // Class Parameterized Constructor
    public CountryStateDistrictMapDataManipulation(String firstLetter) {
        
        List<District__c> districtList = [Select Name, State_Name__r.Name, State_Name__r.Country_Name__r.Name From District__c];
        List<String> combinationOfCountryStateAndDistrict = new list<String>();
        If(districtList.size() > 0) {
            for(District__c district : districtList) {
                If(!mapOfCountryWithStateAndDistrict.containsKey(district.State_Name__r.Country_Name__r.Name)) {
                    mapOfCountryWithStateAndDistrict.put(district.State_Name__r.Country_Name__r.Name, new Map<String, List<String>>());
                }
                If(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).containsKey(district.State_Name__r.Name)) {
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).put(district.State_Name__r.Name, new List<String>());
                }
                If(!mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).contains(district.Name)) {
                    mapOfCountryWithStateAndDistrict.get(district.State_Name__r.Country_Name__r.Name).get(district.State_Name__r.Name).add(district.Name);
                    If(district.State_Name__r.Country_Name__r.Name.startsWithIgnoreCase(firstLetter)) {
                        If(district.State_Name__r.Name.startsWithIgnoreCase(firstLetter)) {
                            If(district.Name.startsWithIgnoreCase(firstLetter)) {
                                combinationOfCountryStateAndDistrict.add(district.State_Name__r.Country_Name__r.Name + ' -> ' + district.State_Name__r.Name + ' -> ' + district.Name);
                            }
                        }
                    }
                }
            }
        }
        System.debug('Map of Country, State and District ==> ' + mapOfCountryWithStateAndDistrict);
        System.debug('Combination of Country, State and District ==> ' + combinationOfCountryStateAndDistrict); 
        findTotalStateAndDistrict();        
    }

    /* 
        *    @Description    :      Inside this method we update the total districts, total states of country & states using Aggregate query.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  13/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    // Method
    public static void findTotalStateAndDistrict() {
        List<State__c> listOfDistrictInStateToUpdate = new List<State__c>();
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();
        List<Country__c> listOfDistrictInCountryToUpdate = new List<Country__c>();

        // Aggregate query for find total number of districts inside a State.
        AggregateResult[] districtAggregateResultForState = [Select Count(Id) Total_District, State_Name__c From District__c GROUP BY State_Name__c];
        for(AggregateResult ar : districtAggregateResultForState) {
            State__c state = new State__c();
            state.Id = (Id)ar.get('State_Name__c');
            state.Total_Districts__c = (Integer)ar.get('Total_District');
            listOfDistrictInStateToUpdate.add(state);
        }

        System.debug('listOfDistrictInStateToUpdate - ' + listOfDistrictInStateToUpdate);
        if(listOfDistrictInStateToUpdate.size() > 0) {
            update listOfDistrictInStateToUpdate;
            System.debug('District List Of State Has Updated Successfully');
        }

        // Aggregate query for find total number of states inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c From State__c GROUP BY Country_Name__c];
        for(AggregateResult ar : stateAggregateResultForCountry) {
            Country__c country = new Country__c();
            country.Id = (Id)ar.get('Country_Name__c');
            country.Total_States__c = (Integer)ar.get('Total_State');
            listOfStateInCountryToUpdate.add(country);
        }
        System.debug('listOfStateInCountryToUpdate - ' + listOfStateInCountryToUpdate);
        if(listOfStateInCountryToUpdate.size() > 0) {
            update listOfStateInCountryToUpdate;
            System.debug('State List Of Country Has Updated Successfully');
        } 

        // Aggregate query for find total number of districts inside a country. 
        AggregateResult[] districtAggregateResultForCountry = [Select Count(Id) Total_District, State_Name__r.Country_Name__c From District__c GROUP BY State_Name__r.Country_Name__c];
        for(AggregateResult ar : districtAggregateResultForCountry) {
            Country__c country = new Country__c();
            country.Id = (Id)ar.get('Country_Name__c');
            country.Total_Districts__c = (Integer)ar.get('Total_District');
            listOfDistrictInCountryToUpdate.add(country);
        }
        System.debug('listOfDistrictInCountryToUpdate - ' + listOfDistrictInCountryToUpdate);
        if(listOfDistrictInCountryToUpdate.size() > 0) {
            update listOfDistrictInCountryToUpdate;
            System.debug('District List Of Country Has Updated!');
        }
    }

    /* 
        *    @Description    :      JSON Method for update the JSON data in database.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  14/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public void CountryJSONGenerator(String countryName) {
        List<Country__c> countryList = [Select Id, Name, Total_Districts__c, Total_States__c, Country_Code__c, Country_JSON_Data__c From Country__c Where Name =:countryName];

        If(countryList.size() > 0) {

            List<StateWrapper> stateWrapperList = new List<StateWrapper>();
            for(String state : mapOfCountryWithStateAndDistrict.get(countryName).keySet()) {
                StateWrapper stateWrapperObj = new StateWrapper();
                stateWrapperObj.stateName = state;

                List<DistrictWrapper> districtWrapperList = new List<DistrictWrapper>();
                for(String district : mapOfCountryWithStateAndDistrict.get(countryName).get(state)) {
                    DistrictWrapper districtWrapperObj = new DistrictWrapper();
                    districtWrapperObj.district = district;
                    districtWrapperList.add(districtWrapperObj);
                }
                stateWrapperObj.districts = districtWrapperList;
                stateWrapperList.add(stateWrapperObj);
            } 

            CountryWrapper countryWrapperObj = new CountryWrapper();
            countryWrapperObj.countryName = countryList[0].Name;
            countryWrapperObj.countryCode = countryList[0].Country_Code__c;
            countryWrapperObj.totalStates = (Integer)countryList[0].Total_States__c;
            countryWrapperObj.totalDistricts = (Integer)countryList[0].Total_Districts__c;
            countryWrapperObj.state = stateWrapperList;

            System.debug(countryWrapperObj);
            System.debug(JSON.serialize(countryWrapperObj));
            countryList[0].Country_JSON_Data__c = JSON.serialize(countryWrapperObj);
            update countryList;
        }
        System.debug('JSON Running successfully!!');
    }

    /*      
        *   @Description    :    Wrapper class for country.(Inner Class)
        *
        *   @Created By     :    Shubham Kumar
        *        
        *   @Created Date   :    14/07/2022
        *
        *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
        *                             
    */

    public class CountryWrapper {
        public String countryName;
        public String countryCode;
        public Integer totalStates;
        public Integer totalDistricts;
        public List<StateWrapper> State;
    }

    /*      
        *   @Description    :    Wrapper class for state.(Inner Class)
        *
        *   @Created By     :    Shubham Kumar
        *        
        *   @Created Date   :    14/07/2022
        *
        *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
        *                             
    */

    public class StateWrapper {
        public String stateName;
        public List<DistrictWrapper> districts;
    }

    /*      
    *   @Description    :    Wrapper class for district.(Inner Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    14/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
*/

    public class DistrictWrapper {
        public String district;
    }
}