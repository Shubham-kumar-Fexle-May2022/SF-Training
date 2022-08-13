/*      
    *   @Description    :    The code of this class is responsible for create/update/delete the automobile records at the time of create an opportunity.
    *                        And send the mail to the opportunity owner about the sensors are valid or not, and many more other datails.
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    29/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -   Shubham Kumar                            
*/

public with sharing class OpportunityTriggerHandler {

    /*
        *    @Description    :       In this method we insert/Update automobile records according to stage field at the time of opportunity creation.
        *
        *    @args           :       List<Opportunity>, Map<Id, Opportunity>
        *
        *    @return         :       void(Nothing).
        *
        *    @revision Log   :       V1.1  - Created  -  30/07/2022  - Shubham Kumar 
        *                                    
    */

    Integer insertFlag = 0;
    Integer updateFlag = 0;

    public static void insertAndUpdateRecords(List<Opportunity> newOppList, Map<Id, Opportunity> oldMapOfOpp) {
        
        // Lists of SObjects.
        List<SObject> insertListOfSensors = new List<SObject>();
        List<SObject> updateListOfSensors = new List<SObject>();

        Set<Id> setOfOppIds = new Set<Id>();
        for(Opportunity opp : newOppList) {
            setOfOppIds.add(opp.Id);
        }
        
        // Old records list of Automobile sensors.
        List<SObject> listOfautomobileOldRecords = new List<SObject>();
        listOfautomobileOldRecords.addAll([Select Id, Name, Account__c From Automobile_Sensor__c Where Opportunity__c In: setOfOppIds]);
        listOfautomobileOldRecords.addAll([Select Id, Name, Account__c From Automobile_Presence_Sensor__c Where Opportunity__c In: setOfOppIds]);
        listOfautomobileOldRecords.addAll([Select Id, Name, Account__c From Automobile_TDU__c Where Opportunity__c In: setOfOppIds]);
        listOfautomobileOldRecords.addAll([Select Id, Name, Account__c From Automobile_Tag__c Where Opportunity__c In: setOfOppIds]);

        // Fill the Map of old records.
        Map<String, SObject> oldMapOfAutomobileRecords = new Map<String, SObject>();
        for(SObject oldRecord : listOfautomobileOldRecords) {
            oldMapOfAutomobileRecords.put((String)oldRecord.get('Name'), oldRecord);
        }
        System.debug('oldMapOfAutomobileRecords => ' + oldMapOfAutomobileRecords);
        
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        // Iterate The New Opportunity list.
        for(Opportunity opp : newOppList) {

            if((opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to HQ' || opp.StageName == 'Return to Customer') && 
            (oldMapOfOpp == null || opp.StageName != oldMapOfOpp.get(opp.Id).StageName || 
            opp.Automobile_Tag_Details_1__c != oldMapOfOpp.get(opp.Id).Automobile_Tag_Details_1__c ||
            opp.Automobile_Tag_Details_2__c != oldMapOfOpp.get(opp.Id).Automobile_Tag_Details_2__c ||
            opp.Automobile_Tag_Details_3__c != oldMapOfOpp.get(opp.Id).Automobile_Tag_Details_3__c ||
            opp.Return_To_HQ__c != oldMapOfOpp.get(opp.Id).Return_To_HQ__c)) {

                // Email sending Process.
                Messaging.SingleEmailMessage emailMsg =  new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{opp.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSubject = opp.Name + ' , ' + system.toDay().format();
                emailMsg.setSubject(emailSubject);
                String senderName = 'Shubham Kumar';
                emailMsg.setSenderDisplayName(senderName);
                String content = 'Sensor shipment process is completed.<br><b> Successful: <b><br><table border="1" cellpadding=5 cellspacing=0><tr><th> Automobile Type </th><th> Name </th><th> Message </th></tr>';
                // SOQL Query for getting Account Names.
                Account installationAccount = [SELECT Name FROM Account WHERE Id =: opp.AccountId];
                Account shipmentAccount = [SELECT Name From Account WHERE Id =: opp.Shipment_Account__c];

                // Set which contains opp Tag datail filds.
                Set<String> setOfAutomobileTags = new Set<String>();
                If(opp.Automobile_Tag_Details_1__c != null) {
                    for(String str : opp.Automobile_Tag_Details_1__c.split('\n')) {
                        setOfAutomobileTags.add(str.trim());
                    }
                }
                If(opp.Automobile_Tag_Details_2__c != null) {
                    for(String str : opp.Automobile_Tag_Details_2__c.split('\n')) {
                        setOfAutomobileTags.add(str.trim());
                    }
                }
                If(opp.Automobile_Tag_Details_3__c != null) {
                    for(String str : opp.Automobile_Tag_Details_3__c.split('\n')) {
                        setOfAutomobileTags.add(str.trim());
                    }
                }
                If(opp.Return_To_HQ__c != null) {
                    for(String str : opp.Return_To_HQ__c.split('\n')) {
                        setOfAutomobileTags.add(str.trim());
                    }
                }
                
                If(setOfAutomobileTags != null) {
                    for(String str : setOfAutomobileTags) {
                        If(str.length() > 18) {
                            str.trim();
                            str = str.subString(0,18);
                        }
                        If(str.startsWith('00:11:CE:00')) {
                            // Update the record which is already exist in the map.
                            If(oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Sensor__c autoSensor = (Automobile_Sensor__c)oldMapOfAutomobileRecords.get(str);
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    AutoSensor.Account__c = opp.AccountId;
                                    AutoSensor.Opportunity__c = opp.Id;
                                    updateListOfSensors.add(autoSensor);
                                }
                                if(opp.StageName == 'Return to Customer' && autoSensor.Account__c == opp.AccountId) {
                                    content += '<tr><td>Automobile Sensor</td><td>'+ str +'</td><td>Sensor cannot inserted  under installation account' + installationAccount.Name + 'b/c it is already exists under the installation account.</td></tr>';
                                    system.debug('update automobile sensor -' + content);
                                }
                            }
                            // Insert the record which is not in the map.
                            If(!oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Sensor__c autoSensor = new Automobile_Sensor__c();
                                autoSensor.Name = str;
                                autoSensor.opportunity__c = opp.Id;
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoSensor.Account__c = opp.AccountId;
                                } else If(opp.StageName == 'Return to HQ') {
                                    autoSensor.Account__c = opp.Shipment_Account__c;
                                }
                                insertListOfSensors.add(autoSensor);     
                            } 
                            content += '<tr><td>Automobile Sensor</td><td>'+ str +'</td><td>Sensor inserted under installation account : ' + installationAccount.Name + '</td></tr>';
                            system.debug('insert automobile sensor -' + content);
                        } else If(str.startsWith('00:11:CE:D')) {
                            If(oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Presence_Sensor__c autoPSensor = (Automobile_Presence_Sensor__c)oldMapOfAutomobileRecords.get(str);
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    AutoPSensor.Account__c = opp.AccountId;
                                    AutoPSensor.Opportunity__c = opp.Id;
                                    updateListOfSensors.add(autoPSensor);
                                }
                                if(opp.StageName == 'Return to Customer' && autoPSensor.Account__c == opp.AccountId) {
                                    content += '<tr><td>Automobile Presence Sensor</td><td>'+ str +'</td><td> Automobile Presence Sensor can not inserted  under installation account' + installationAccount.Name + 'b/c it is already exists under the installation account.</td></tr>';
                                    system.debug('update automobile sensor -' + content);
                                }
                            }
                            If(!oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Presence_Sensor__c autoPSensor = new Automobile_Presence_Sensor__c();
                                autoPSensor.Name = str;
                                autoPSensor.opportunity__c = opp.Id;
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoPSensor.Account__c = opp.AccountId;
                                } else If(opp.StageName == 'Return to HQ') {
                                    autoPSensor.Account__c = opp.Shipment_Account__c;
                                }
                                insertListOfSensors.add(autoPSensor);
                                content += '<tr><td>Automobile Presence Sensor</td><td>'+ str +'</td><td>Sensor inserted under installation account : '+ installationAccount.Name + '</td></tr>';
                                system.debug('insert automobile Presence sensor -' + content);
                            }
                        } else If(str.startsWith('00:11:CE:E')) {
                            If(oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_TDU__c autoTDUSensor = (Automobile_TDU__c)oldMapOfAutomobileRecords.get(str);
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoTDUSensor.Account__c = opp.AccountId;
                                    autoTDUSensor.Opportunity__c = opp.Id;
                                    updateListOfSensors.add(autoTDUSensor);
                                }
                                if(opp.StageName == 'Return to Customer' && autoTDUSensor.Account__c == opp.AccountId) {
                                    content += '<tr><td>Automobile TDU Sensor</td><td>'+ str +'</td><td> Automobile TDU Sensor can not inserted  under installation account' + installationAccount.Name + 'b/c it is already exists under the installation account.</td></tr>';
                                    system.debug('update automobile sensor -' + content);
                                }
                            }
                            If(!oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_TDU__c autoTDUSensor = new Automobile_TDU__c();
                                autoTDUSensor.Name = str;
                                autoTDUSensor.opportunity__c = opp.Id;
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoTDUSensor.Account__c = opp.AccountId;
                                } else If(opp.StageName == 'Return to HQ') {
                                    autoTDUSensor.Account__c = opp.Shipment_Account__c;
                                }
                                insertListOfSensors.add(autoTDUSensor);
                                content += '<tr><td>Automobile TDU Sensor</td><td>'+ str +'</td><td>Sensor inserted under installation account : ' + installationAccount.Name +'</td></tr>';
                                system.debug('insert automobile TDU sensor -' + content);
                            }
                        } else If(str.subString(1,3).isNumeric()) {
                            If(oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Tag__c autoTagSensor = (Automobile_Tag__c)oldMapOfAutomobileRecords.get(str);
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoTagSensor.Account__c = opp.AccountId;
                                    autoTagSensor.Opportunity__c = opp.Id;
                                    updateListOfSensors.add(autoTagSensor);
                                }
                                if(opp.StageName == 'Return to Customer' && autoTagSensor.Account__c == opp.AccountId) {
                                    content += '<tr><td>Automobile Tag Sensor</td><td>'+ str +'</td><td> Automobile Tag Sensor can not inserted  under installation account' + installationAccount.Name + 'b/c it is already exists under the installation account.</td></tr>';
                                    system.debug('update automobile sensor -' + content);
                                }
                            }
                            If(!oldMapOfAutomobileRecords.containsKey(str)) {
                                Automobile_Tag__c autoTagSensor = new Automobile_Tag__c();
                                autoTagSensor.Name = str;
                                autoTagSensor.opportunity__c = opp.Id;
                                If(opp.stageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer') {
                                    autoTagSensor.Account__c = opp.AccountId;
                                } else If(opp.StageName == 'Return to HQ') {
                                    autoTagSensor.Account__c = opp.Shipment_Account__c;
                                }
                                insertListOfSensors.add(autoTagSensor);
                                content += '<tr><td>Automobile Sensor</td><td>'+ str +'</td><td>Sensor inserted under installation account : ' + installationAccount.Name + '</td></tr>';
                                system.debug('insert automobile Tag sensor -' + content);
                            }
                        }
                    }
                    // Return to HQ
                    If(opp.StageName == 'Return to HQ' && (opp.Return_To_HQ__c != null || opp.Return_To_HQ__c != '')) {
                        Set<String> setOfTags = new Set<String>();
                        for(String str : opp.Return_To_HQ__c.split('\n')) {
                            setOfTags.add(str.trim());
                        }
                        If(setOfTags.size() > 0) {
                            for(String str : setOfTags) {
                                If(oldMapOfAutomobileRecords.containsKey(str)) {
                                    If(str.startsWith('00:11:CE:00')) {
                                        Automobile_Sensor__c autoSensor = (Automobile_Sensor__c)oldMapOfAutomobileRecords.get(str);
                                        autoSensor.Account__c = opp.Shipment_Account__c;
                                        updateListOfSensors.add(autoSensor);
                                        content += '<tr><td>Automobile Sensor</td><td>' + str + '</td><td>Sensor moved from installation account to Shipment account : ' + shipmentAccount.Name + '</td></tr>';
                                    }
                                    If(str.startsWith('00:11:CE:D')) {
                                        Automobile_Presence_Sensor__c autoPSensor = (Automobile_Presence_Sensor__c)oldMapOfAutomobileRecords.get(str);
                                        autoPSensor.Account__c = opp.Shipment_Account__c;
                                        updateListOfSensors.add(autoPSensor);
                                        content += '<tr><td>Automobile Presence Sensor</td><td>' + str + '</td><td>Sensor moved from installation account to Shipment account : ' + shipmentAccount.Name + '</td></tr>';
                                    }
                                    If(str.startsWith('00:11:CE:E')) {
                                        Automobile_TDU__c autoTDUSensor = (Automobile_TDU__c)oldMapOfAutomobileRecords.get(str);
                                        autoTDUSensor.Account__c = opp.Shipment_Account__c;
                                        updateListOfSensors.add(autoTDUSensor);
                                        content += '<tr><td>Automobile TDU Sensor</td><td>' + str + '</td><td>Sensor moved from installation account to Shipment account : ' + shipmentAccount.Name + '</td></tr>';
                                    }
                                    If(str.subString(1,3).isNumeric()) {
                                        Automobile_Tag__c autoTagSensor = (Automobile_Tag__c)oldMapOfAutomobileRecords.get(str);
                                        autoTagSensor.Account__c = opp.Shipment_Account__c;
                                        updateListOfSensors.add(autoTagSensor);
                                        content += '<tr><td>Automobile Tag Sensor</td><td>' + str + '</td><td>Sensor moved from installation account to Shipment account : ' + shipmentAccount.Name + '</td></tr>';
                                    }
                                }
                            }
                        }
                    }
                }
                content = content + '</table>'+'<br/>';
                string content2 = '<b>Unsuccessful:</b><br><table border="1" cellpadding=5 cellspacing=0>' + '<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';
                //Unsuccessful
                if(!setOfAutomobileTags.isEmpty()) {
                    //content2 += '<b> Unsuccessful:</b> <table border="1" cellpadding=5 cellspacing=0>' + '<tr><th>Automobile Type</th><th>Name</th> <th>Message</th></tr>';
                    for(String tag : setOfAutomobileTags) {
                        if(!tag.startsWith('00:11:CE:00') && !tag.startsWith('00:11:CE:D') && !tag.startsWith('00:11:CE:E') && !tag.substring(0,3).isNumeric()
                            && (opp.StageName == 'Prospect' || opp.StageName == 'Qualification' || opp.StageName=='Processing' || opp.StageName=='Closed Lost'
                            || opp.StageName == 'Return To HQ' || opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return to Customer')) {        
                            content2 += '<tr><td>Sensor</td><td>'+tag+'</td><td>Invalid Sensor</td></tr>';
                            system.debug('Invalid sensor- ' + content2);
                        }
                    }
                    content2 = content2 + '</table>'+'<br/>';
                }
                emailMsg.setHtmlBody(content + content2);
                //emailMsg.setHtmlBody(content2);
                emailList.add(emailMsg);
            }
        }
        

        System.debug('Insert List -> ' + insertListOfSensors);
        System.debug('Update List -> ' + updateListOfSensors);
        // Insert List.
        If(!insertListOfSensors.isEmpty()) {
            insert insertListOfSensors;
        }
        // Update List.
        If(!updateListOfSensors.isEmpty()) {
            update updateListOfSensors;
        }
        If(!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        }
    }
}