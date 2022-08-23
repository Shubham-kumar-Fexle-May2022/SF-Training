/*      
    *   @Description    :    The code of this class is responsible for update the State and country data if we perform any operation from UI.                       
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    16/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar                            
*/

public with sharing class StateTriggerHandler {

    /*
        *    @Description    :       If we insert the new state then one count will be increased on country object and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  17/08/2022  - Shubham Kumar 
        *                                    
    */
    // Insert Case
    public static Map<String, Map<String, List<String>>> mapOfCountryWithStateAndDistrict = new Map<String, Map<String, List<String>>>();
    public static void updateStateAndCountryIfStateIsInserted(List<State__c> newStateList) {
        
        // Count total number or districts and states using aggregate query.
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();
        Set<Id> setOfCountriesId = new Set<Id>();

        List<State__c> listOfStates = [Select Id, Name, Country_Name__c From State__c Where Id In : newStateList]; 
        // Iterate state new list.
        for (State__c s : newStateList) {
            setOfCountriesId.add(s.Country_Name__c);
        }

        System.debug('listOfStates: ' + listOfStates);
        System.debug('newStateList: ' + newStateList);
        

        // Aggregate query for find total number of states and districts inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(State__c state : listOfStates) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(state.Country_Name__c == ar.get('Country_Name__c')) {
                    Country__c country = new Country__c();
                    country.Id = (Id)ar.get('Country_Name__c');
                    country.Total_States__c = (Decimal)ar.get('Total_State');
                    country.Total_Districts__c = (Decimal)ar.get('NumofDistricts');
                    If(!listOfStateInCountryToUpdate.contains(country)) {
                        listOfStateInCountryToUpdate.add(country);
                    }
                }
            }
        }
        System.debug('listOfStateInCountryToUpdate ' + listOfStateInCountryToUpdate);
        System.debug('setOfCountriesId -> ' + setOfCountriesId);
        if(!listOfStateInCountryToUpdate.isEmpty()) {
            update listOfStateInCountryToUpdate;
            CountryJSONGenerator(setOfCountriesId);
        }
    }

    /*
        *    @Description    :       If we move the state from one country to another country then one count will be decresed in existing country and one count will be incresed in updated country and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>, List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  16/08/2022  - Shubham Kumar 
        *                                    
    */
    // Update Case

    public static void updateStateAndCountryIfStateIsUpdated(List<State__c> newStateList, List<State__c> oldStateList) {
        
        // Count total number or districts and states using aggregate query.
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();
        Set<Id> setOfCountriesId = new Set<Id>();

        List<State__c> listOfStates = [Select Id, Name, Country_Name__c From State__c Where Id In : newStateList]; 

        for (State__c s : newStateList) {
            setOfCountriesId.add(s.Country_Name__c);
        }
        for (State__c s : oldStateList) {
            setOfCountriesId.add(s.Country_Name__c);
        }
        if (!oldStateList.isEmpty()) {
            for (State__c st : oldStateList) {
                if (!listOfStates.contains(st)) {
                    listOfStates.add(st);                    
                }
            }
        }

        System.debug('listOfStates 38: ' + listOfStates);
        System.debug('oldStateList 39: ' + oldStateList);
        System.debug('newStateList 40: ' + newStateList);
        

        // Aggregate query for find total number of states and districts inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(State__c state : listOfStates) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(state.Country_Name__c == ar.get('Country_Name__c')) {
                    Country__c country = new Country__c();
                    country.Id = (Id)ar.get('Country_Name__c');
                    country.Total_States__c = (Decimal)ar.get('Total_State');
                    country.Total_Districts__c = (Decimal)ar.get('NumofDistricts');
                    If(!listOfStateInCountryToUpdate.contains(country)) {
                        listOfStateInCountryToUpdate.add(country);
                    }
                }
            }
        }
        System.debug('listOfStateInCountryToUpdate - ' + listOfStateInCountryToUpdate);
        if(!listOfStateInCountryToUpdate.isEmpty()) {
            update listOfStateInCountryToUpdate;
            CountryJSONGenerator(setOfCountriesId);
        } 
    }

    /*
        *    @Description    :       If we delete the existing state then one count will be decreased on country object and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  17/08/2022  - Shubham Kumar 
        *                                    
    */
    // Delete Case

    public static void updateStateAndCountryIfStateIsDeleted(List<State__c> oldStateList) {
        
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();
        Set<Id> setOfCountriesId = new Set<Id>();

        List<State__c> listOfStates = [Select Id, Name, Country_Name__c From State__c]; 

        for (State__c s : oldStateList) {
            setOfCountriesId.add(s.Country_Name__c);
        }

        System.debug('listOfStates- ' + listOfStates);
        System.debug('oldStateList- ' + oldStateList);
        

        // Aggregate query for find total number of states and districts inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(State__c state : listOfStates) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(state.Country_Name__c == ar.get('Country_Name__c')) {
                    Country__c country = new Country__c();
                    country.Id = (Id)ar.get('Country_Name__c');
                    country.Total_States__c = (Decimal)ar.get('Total_State');
                    country.Total_Districts__c = (Decimal)ar.get('NumofDistricts');
                    If(!listOfStateInCountryToUpdate.contains(country)) {
                        listOfStateInCountryToUpdate.add(country);
                    }
                }
            }
        }
        System.debug('listOfStateInCountryToUpdate- ' + listOfStateInCountryToUpdate);
        System.debug('setOfCountriesId -> ' + setOfCountriesId);
        if(!listOfStateInCountryToUpdate.isEmpty()) {
            update listOfStateInCountryToUpdate;
            CountryJSONGenerator(setOfCountriesId);
        }
    }
    // Update JSON Data
    public static void CountryJSONGenerator(Set<Id> setOfCountriesId) {
        // Filling Global Map
        List<Country__c> countryName = [Select Id, Name From Country__c];
        
        // List to hold State Records
        List<State__c> stateName = [Select Id, Name, Country_Name__c From State__c Order By Name];

        // List to hold District Records
        List<District__c> districtName = [Select Id, Name, State_Name__c From District__c];
        
        //Fill Global Map
        for (Country__c c : countryName) {
            List<String> listTempState = new List<String>();
            Map<String, List<String>> mapTempState = new Map<String, List<String>>();
            for (State__c s : stateName) {
                if (s.Country_Name__c == c.Id) {
                    listTempState.add(s.Name);
                    List<String> listTempDistrict = new List<String>();
                    for (District__c d : districtName) {
                        if (d.State_Name__c == s.Id) {
                            listTempDistrict.add(d.Name);
                        }
                    }
                    mapTempState.put(s.Name, listTempDistrict);
                }    
            }
            mapOfCountryWithStateAndDistrict.put(c.Name, mapTempState);
        }
        System.debug('Global Map==> ' +mapOfCountryWithStateAndDistrict);

        List<Country__c> countryList = [Select Id, Name, Total_Districts__c, Total_States__c, Country_Code__c, Country_JSON_Data__c From Country__c Where Id =:setOfCountriesId];
        System.debug('countrylist 223-> ' + countryList);  

        If(countryList.size() > 0) {
            for(Country__c cont : countryList) {

                CountryWrapper countryWrapperObj = new CountryWrapper();
                List<StateWrapper> stateWrapperList = new List<StateWrapper>();
                for(String state : mapOfCountryWithStateAndDistrict.get(cont.Name).keySet()) {
                    StateWrapper stateWrapperObj = new StateWrapper();
                    stateWrapperObj.stateName = state;

                    List<DistrictWrapper> districtWrapperList = new List<DistrictWrapper>();
                    for(String district : mapOfCountryWithStateAndDistrict.get(cont.Name).get(state)) {
                        DistrictWrapper districtWrapperObj = new DistrictWrapper();
                        districtWrapperObj.district = district;
                        districtWrapperList.add(districtWrapperObj);
                    }
                    stateWrapperObj.districts = districtWrapperList;
                    stateWrapperList.add(stateWrapperObj);
                } 
                countryWrapperObj.countryName = cont.Name;
                countryWrapperObj.countryCode = cont.Country_Code__c;
                countryWrapperObj.totalStates = (Integer)cont.Total_States__c;
                countryWrapperObj.totalDistricts = (Integer)cont.Total_Districts__c;
                countryWrapperObj.state = stateWrapperList;
                System.debug('countryWrapperObj -> ' + countryWrapperObj);
                System.debug('JSON Data -> ' + JSON.serialize(countryWrapperObj));
                // Serialize method
                cont.Country_JSON_Data__c = JSON.serialize(countryWrapperObj);
            }
            update countryList;    
        }
    }

    // Country Wrapper Class.
    public class CountryWrapper {
        public String countryName;
        public String countryCode;
        public Integer totalStates;
        public Integer totalDistricts;
        public List<StateWrapper> State;
    }

    // State Wrapper Class
    public class StateWrapper {
        public String stateName;
        public List<DistrictWrapper> districts;
    }

    // District Wrapper Class.
    public class DistrictWrapper {
        public String district;
    }
}