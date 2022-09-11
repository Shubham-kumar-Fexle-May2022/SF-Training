public with sharing class DisplayContactOppAndCase {
    @AuraEnabled
    public static List<Account> getAccountsForCombobox(){
        List<Account> accountList = [Select Id, Name From Account];
        return accountList;
    }

    @AuraEnabled
    public static List<Contact> getContacts(String selectedAccountId){
        List<Contact> contactList = [Select Id, Name, AccountId, Email From Contact Where AccountId =: selectedAccountId];
        return contactList;
    }
    
    @AuraEnabled
    public static List<Opportunity> getOpportunities(String selectedAccountId){
        List<Opportunity> oppList = [Select Id, Name, AccountId, Email__c From Opportunity Where AccountId =: selectedAccountId];
        return oppList;
    }
    
    @AuraEnabled
    public static List<Case> getCases(String selectedAccountId){
        List<Case> caseList = [Select Id, CaseNumber, AccountId, ContactEmail From Case Where AccountId =: selectedAccountId];
        return caseList;
    }
}