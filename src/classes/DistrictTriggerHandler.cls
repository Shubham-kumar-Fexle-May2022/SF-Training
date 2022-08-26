/*      
    *   @Description    :    The code of this class is responsible for update district, state, country object data If we update the records from UI. 
    *                   
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    10/08/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar                            
*/

public with sharing class DistrictTriggerHandler {

    /*
        *    @Description    :       If we insert the new district then one count will be increased on state and country object and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  14/08/2022  - Shubham Kumar 
        *                                    
    */
    // Insert Case
    public static Map<String, Map<String, List<String>>> mapOfCountryWithStateAndDistrict = new Map<String, Map<String, List<String>>>();
    public static void updateDistrictStateAndCountryIfDistrictIsInserted(List<District__c> distNewList) {
        // Count total number or districts and states using aggregate query.
        List<State__c> listOfDistrictInStateToUpdate = new List<State__c>();
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();

        // List of country Ids
        List<Id> listOfContId = new List<Id>();

        // retrieve district record according to district new list.
        List<District__c> listOfDistrict = [Select Id, Name, State_Name__c, State_Name__r.Country_Name__r.Id From District__c Where Id In : distNewList];            
        for (District__c dis : listOfDistrict) {
            listOfContId.add(dis.State_Name__r.Country_Name__r.Id);
        }

        System.debug('distNewList : ' + distNewList);
        System.debug('listOfDistrict : ' + listOfDistrict);
        
        // Aggregate query for find total number of districts inside a State.
        AggregateResult[] districtAggregateResultForState = [Select Count(Id) Total_District, State_Name__c From District__c GROUP BY State_Name__c];
        for(District__c dist : listOfDistrict) {
            for(AggregateResult ar : districtAggregateResultForState) {
                If(dist.State_Name__c == ar.get('State_Name__c')) {
                    State__c state = new State__c();
                    state.Id = (Id)ar.get('State_Name__c');
                    state.Total_Districts__c = (Integer)ar.get('Total_District');
                    listOfDistrictInStateToUpdate.add(state);
                }   
            }
        }

        System.debug('listOfDistrictInStateToUpdate - ' + listOfDistrictInStateToUpdate);
        if(listOfDistrictInStateToUpdate.size() > 0) {
            update listOfDistrictInStateToUpdate;
            System.debug('District List Of State Has Updated Successfully');
        }

        // Aggregate query for find total number of states inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(District__c dist : listOfDistrict) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(dist.State_Name__r.Country_Name__r.Id == ar.get('Country_Name__c')) {
                    Country__c country = new Country__c();
                    country.Id = (Id)ar.get('Country_Name__c');
                    country.Total_States__c = (Decimal)ar.get('Total_State');
                    country.Total_Districts__c = (Decimal)ar.get('NumofDistricts');
                    listOfStateInCountryToUpdate.add(country);
                }
            }
        }
        System.debug('listOfStateInCountryToUpdate - ' + listOfStateInCountryToUpdate);
        if(listOfStateInCountryToUpdate.size() > 0) {
            update listOfStateInCountryToUpdate;
            CountryJSONGenerator(listOfContId);
            System.debug('State List Of Country Has Updated Successfully');
        } 
    }
    /*
        *    @Description    :       If we move the district from one state to another state then one count will be decresed in existing state and one count will be incresed in updated state and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>, List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  14/08/2022  - Shubham Kumar 
        *                                    
    */
    // Update Case
    
    public static void updateDistrictStateAndCountryIfDistrictIsUpdated(List<District__c> listOfDistricts, List<District__c> oldList) {
        
        // Count total number or districts and states using aggregate query.
        List<State__c> listOfDistrictInStateToUpdate = new List<State__c>();
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();

        // List of country Ids
        List<Id> listOfContId = new List<Id>();

        List<District__c> listOfDist = [Select Id, Name, State_Name__c, State_Name__r.Country_Name__r.Id From District__c Where Id In : listOfDistricts];            
        for (District__c d : listOfDist) {
            listOfContId.add(d.State_Name__r.Country_Name__r.Id);
        }
        if (!oldList.isEmpty()) {
            for (District__c dis : oldList) {
                listOfDist.add(dis);
            }
        }

        System.debug('listOfDistricts : ' + listOfDistricts);
        System.debug('listOfDist : ' + listOfDist);
        
        // Aggregate query for find total number of districts inside a State.
        AggregateResult[] districtAggregateResultForState = [Select Count(Id) Total_District, State_Name__c From District__c GROUP BY State_Name__c];
        for(District__c dist : listOfDist) {
            for(AggregateResult ar : districtAggregateResultForState) {
                If(dist.State_Name__c == ar.get('State_Name__c')) {
                    State__c state = new State__c();
                    state.Id = (Id)ar.get('State_Name__c');
                    state.Total_Districts__c = (Integer)ar.get('Total_District');
                    listOfDistrictInStateToUpdate.add(state);
                }   
            }
        }

        System.debug('listOfDistrictInStateToUpdate - ' + listOfDistrictInStateToUpdate);
        if(listOfDistrictInStateToUpdate.size() > 0) {
            update listOfDistrictInStateToUpdate;
            System.debug('District List Of State Has Updated Successfully');
        }

        // Aggregate query for find total number of states inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(District__c dist : listOfDist) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(dist.State_Name__r.Country_Name__r.Id == ar.get('Country_Name__c')) {
                    Country__c country = new Country__c();
                    country.Id = (Id)ar.get('Country_Name__c');
                    country.Total_States__c = (Decimal)ar.get('Total_State');
                    country.Total_Districts__c = (Decimal)ar.get('NumofDistricts');
                    listOfStateInCountryToUpdate.add(country);
                }
            }
        }
        System.debug('listOfStateInCountryToUpdate - ' + listOfStateInCountryToUpdate);
        if(listOfStateInCountryToUpdate.size() > 0) {
            update listOfStateInCountryToUpdate;
            CountryJSONGenerator(listOfContId);
            System.debug('State List Of Country Has Updated Successfully');
        } 
    }

    /*
        *    @Description    :       If we delete the existing district then one count will be decreased on state and country object and JSON will also be updated accordingly.
        *
        *    @args           :       List<District__c>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  14/08/2022  - Shubham Kumar 
        *                                    
    */
    // Delete Case

    public static void updateDistrictStateAndCountryIfDistrictIsDeleted(List<District__c> distOldList) {
        // Count total number or districts and states using aggregate query.
        List<State__c> listOfDistrictInStateToUpdate = new List<State__c>();
        List<Country__c> listOfStateInCountryToUpdate = new List<Country__c>();
        // List of country Ids
        List<Id> listOfContId = new List<Id>();

        List<District__c> listOfDistrict = [Select Id, Name, State_Name__c, State_Name__r.Country_Name__r.Id From District__c];            
        for (District__c d : listOfDistrict) {
            listOfContId.add(d.State_Name__r.Country_Name__r.Id);
        }

        System.debug('distOldList : ' + distOldList);
        System.debug('listOfDistrict : ' + listOfDistrict);
        
        // Aggregate query for find total number of districts inside a State.
        AggregateResult[] districtAggregateResultForState = [Select Count(Id) Total_District, State_Name__c From District__c GROUP BY State_Name__c];
        for(District__c dist : listOfDistrict) {
            for(AggregateResult ar : districtAggregateResultForState) {
                If(dist.State_Name__c == ar.get('State_Name__c')) {
                    State__c state = new State__c();
                    state.Id = (Id)ar.get('State_Name__c');
                    state.Total_Districts__c = (Integer)ar.get('Total_District');
                    If(!listOfDistrictInStateToUpdate.contains(state)) {
                        listOfDistrictInStateToUpdate.add(state);
                    }
                }   
            }
        }

        System.debug('listOfDistrictInStateToUpdate - ' + listOfDistrictInStateToUpdate);
        if(!listOfDistrictInStateToUpdate.isEmpty()) {
            update listOfDistrictInStateToUpdate;
            System.debug('District List Of State Has Updated Successfully');
        }

        // Aggregate query for find total number of states inside country.
        AggregateResult[] stateAggregateResultForCountry = [Select Count(Id) Total_State, Country_Name__c, SUM(Total_Districts__c) NumofDistricts From State__c GROUP BY Country_Name__c];
        for(District__c dist : listOfDistrict) {
            for(AggregateResult ar : stateAggregateResultForCountry) {
                If(dist.State_Name__r.Country_Name__r.Id == ar.get('Country_Name__c')) {
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
            CountryJSONGenerator(listOfContId);
            System.debug('State List Of Country Has Updated Successfully');
        } 
    }

    public static void CountryJSONGenerator(List<Id> listOfCountries) {

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

        List<Country__c> countryList = [Select Id, Name, Total_Districts__c, Total_States__c, Country_Code__c, Country_JSON_Data__c From Country__c Where Id =:listOfCountries];
        System.debug('countrylist -> ' + countryList);

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
                System.debug('Line 117 -> ' + countryWrapperObj);
                System.debug('Line 118 -> ' + JSON.serialize(countryWrapperObj));
                // Serialize method
                cont.Country_JSON_Data__c = JSON.serialize(countryWrapperObj);
            }
            update countryList;    
        }
    }
    
    // Wrapper class for country.
    public class CountryWrapper {
        public String countryName;
        public String countryCode;
        public Integer totalStates;
        public Integer totalDistricts;
        public List<StateWrapper> State;
    }

    // Wrapper class for state
    public class StateWrapper {
        public String stateName;
        public List<DistrictWrapper> districts;
    }

    // Wrapper class for District
    public class DistrictWrapper {
        public String district;
    }
}