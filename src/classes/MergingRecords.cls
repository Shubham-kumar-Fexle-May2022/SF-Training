/*      
    *   @Description    :    Merging two lists. (Class)
    *
    *   @Created By     :    Shubham Kumar
    *        
    *   @Created Date   :    011/07/2022
    *
    *   @Revision Logs  :    V1.0  - Created  -  Shubham Kumar
    *                             
 */

public with sharing class MergingRecords {
    // Constructor
    public MergingRecords() {

        // Insert new accounts
        List<Account> ls = new List<Account>{new Account(name='Acme Inc.'), new Account(name='Acme')};                                        
        insert ls;

        // Queries to get the inserted accounts 
        Account masterAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        Account mergeAcct = [SELECT Id, Name FROM Account WHERE Name = 'Acme' LIMIT 1];
        
        System.debug('First Account - ' + masterAcct);
        System.debug('Second Account - ' + mergeAcct);

        // Add a contact to the account to be merged
        Contact c = new Contact(FirstName='Joe',LastName='Merged');
        c.AccountId = mergeAcct.Id;
        insert c;

        try {
            merge masterAcct mergeAcct;
        } catch (DmlException e) {
            // Process exception
            System.debug('An unexpected error has occurred: ' + e.getMessage()); 
        }

        // Once the account is merged with the master account,
        // the related contact should be moved to the master record.
        masterAcct = [SELECT Id, Name, (SELECT FirstName,LastName From Contacts) FROM Account WHERE Name = 'Acme Inc.' LIMIT 1];
        // System.assert(masterAcct.getSObjects('Contacts').size() > 0);
        // System.assertEquals('Joe', masterAcct.getSObjects('Contacts')[0].get('FirstName'));
        // System.assertEquals('Merged', masterAcct.getSObjects('Contacts')[0].get('LastName'));

        // Verify that the merge record got deleted
        Account[] result = [SELECT Id, Name FROM Account WHERE Id=:masterAcct.Id];
        System.debug('res -' + result);
    }

    /* 
        *    @Description    :      Convert leads.
        *
        *    @args           :       
        *
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  11/07/2022  - Shubham Kumar  - Used for Practise
        *                                    
    */

    public static void convertingLeads() {

        // Account acc = [SELECT Id, Name FROM Account WHERE Name='CompanyNameOfLeadBeingMerged'];
        // Contact con = [SELECT Id, Name FROM Contact WHERE FirstName='FirstName' AND LastName='LastName' AND AccountId = '001...'];

        Lead myLead = new Lead(LastName = 'Fry', Company='Fry And Sons');
        insert myLead;

        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(myLead.id);

        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);

        Database.LeadConvertResult lcr = Database.convertLead(lc);
        //System.assert(lcr.isSuccess());
        System.debug('Lead converted!');
    }
}