/**
    *  Description     :  This is Account trigger handler class.(The content of this class only work on Account Object).
    *
    *  Created By      :  Shubham kumar 
    *
    *  Created Date    :  20/07/2022
    *
    *  Revision Logs   :  V1.0 - Created by - Shubham kumar 
    *
**/

public with sharing class AccountTriggerHandler {

    /* 
        *    @Description    :      The content of this method is used for send an email notification with a random account number on existing email id.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  20/07/2022  - Shubham Kumar 
        *                                    
    */

    public static void sendEmailNotification(List<Account> accList) {
        List<Messaging.Email> emailList = new List<Messaging.Email>();
        for(Account acc : accList) {
            If(acc.Email__c != null) {
                Messaging.SingleEmailMessage emailMsg =  new Messaging.SingleEmailMessage();
                String[] toAddress = new String[]{acc.Email__c};
                emailMsg.setToAddresses(toAddress);
                String emailSubject = 'Congratulations ' + acc.Name;
                emailMsg.setSubject(emailSubject);
                String senderName = 'Shubham Kumar';
                emailMsg.setSenderDisplayName(senderName);
                String content = 'Dear ' + acc.Name + ',<br/><br/>' + ' Your Account Has been created Successfully!! <br> Thank you, for open an account on our Bank, We are always available for you!! <br> Account number: ' + acc.AccountNumber;
                emailMsg.setHtmlBody(content);
                emailList.add(emailMsg);
            }
        }
        // Email Send
        If(!emailList.isEmpty()) {
            Messaging.sendEmail(emailList);
        } 
    }
    
    /* 
        *    @Description    :      This method is used for Combine random account number with selected type value.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  21/07/2022  - Shubham Kumar  
        *                                    
    */ 

    public static void addAccountNumberWithType(List<Account> accList) {
        Integer randomNumber = Integer.valueOf(Math.random() * 100000000); // Generate a random number for AccountNumber.
        for(Account acc : accList) {
            If(acc.Type == 'Saving Account') {
                acc.AccountNumber = 'SB-'+ randomNumber;
            } else If(acc.Type == 'FD Account') {
                acc.AccountNumber = 'FD-'+ randomNumber;
            }
        }
    }
    
    /* 
        *    @Description    :      In this method we perform insert and update operation with records.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  20/07/2022 - Shubham kumar  
        *                                    
    */
    
    public static void insertAndUpdateRecord(List<Account> accList) {
        for(Account acc : accList) {
            // If we insert a new record then it will execute.
            If(Trigger.isInsert) {
                acc.Industry = 'Banking';  // Aotomatic populate at the time of account saved.
                acc.Description = 'Account Created Successfully ' + userInfo.getUserName();
                System.debug('Check Insert List:: Trigger.New ' + Trigger.New);
                System.debug('Check Insert List:: Trigger.Old ' + Trigger.Old);
            }
            // If we update an existing record then it will execute.
            If(Trigger.isUpdate) {
                acc.Industry = 'Agriculture';
                acc.Description = 'Account Updated Successfully ' + userInfo.getUserName();
                System.debug('Check Update List ::: Trigger.New ' + Trigger.New);
                System.debug('Check Update List ::: Trigger.old ' + Trigger.old);
            }
        }
    }

    /* 
        *    @Description    :      In this method we check all the events list for better understanding of triggers and try to to understand how does it work do.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  27/07/2022 - Shubham kumar  
        *                                    
    */

    public static void checkTriggerEvents(List<Account> accNewList, List<Account> accOldList) {
        If(Trigger.isBefore) {
            System.debug('--------------Check Before Trigger-----------');
            If(Trigger.isInsert) {
                System.debug('Check Insert List:: Trigger.New ' + Trigger.New);
                System.debug('Check Insert List:: Trigger.Old ' + Trigger.Old);
            }
            If(Trigger.isUpdate) {
                System.debug('Check Update List:: Trigger.New ' + Trigger.New);
                System.debug('Check Update List:: Trigger.Old ' + Trigger.Old);
            }
            If(Trigger.isDelete) {
                System.debug('Check Delete List:: Trigger.New ' + Trigger.New);
                System.debug('Check Delete List:: Trigger.Old ' + Trigger.Old);
            }
        }
        If(Trigger.isAfter) {
            System.debug('-------------Check After Trigger-------------');
            If(Trigger.isInsert) {
                System.debug('Check Insert List:: Trigger.New ' + Trigger.New);
                System.debug('Check Insert List:: Trigger.Old ' + Trigger.Old);
            }
            If(Trigger.isUpdate) {
                System.debug('Check Update List:: Trigger.New ' + Trigger.New);
                System.debug('Check Update List:: Trigger.Old ' + Trigger.Old);
            }
            If(Trigger.isDelete) {
                System.debug('Check Delete List:: Trigger.New ' + Trigger.New);
                System.debug('Check Delete List:: Trigger.Old ' + Trigger.Old);
            }
            If(Trigger.isUnDelete) {
                System.debug('Check UnDelete List:: Trigger.New ' + Trigger.New);
                System.debug('Check UnDelete List:: Trigger.Old ' + Trigger.Old);
            }
        }
    }

    /* 
        *    @Description    :      This method automatically create a child contact at the time of account inserted.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  22/07/2022 - Shubham kumar  
        *                                    
    */

    public static void createAccountWithContact(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList) {
            Contact con = new Contact();
            con.LastName = acc.Name+'_Contact';
            con.AccountId = acc.Id;
            con.Phone = '9719727963';
            conList.add(con);
        }
        If(!conList.isEmpty()) {
            insert conList;
        }
    }

    /* 
        *    @Description    :      The code of this method is responsible for creating related opportunity with a corresponding account.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  22/07/2022 - Shubham kumar  
        *                                    
    */

    public static void createAccountWithOpportunity(List<Account> accList) {
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc : acclist) {
            If(acc.NumberOfEmployees > 0) {
                for(Integer i = 1; i <= acc.NumberOfEmployees; i++) {
                    Opportunity opp = new Opportunity();
                    opp.AccountId = acc.Id;
                    opp.Name = acc.Name +'-'+ i;
                    opp.CloseDate = System.today();
                    opp.StageName = 'Prospecting';
                    oppList.add(opp);
                }
                If(!oppList.isEmpty()) {
                    insert oppList;
                }
            }
        }
    }

    /* 
        *    @Description    :      The code of this method is responsible for populate the property object status on Account object.
        *
        *    @args           :       
        *
        *    @return         :       void (Nothing)
        *
        *    @revision Log   :       V1.1  - Created  -  22/07/2022 - Shubham kumar  
        *                                    
    */

    Public static void populateAccountWithProperty(List<Account> newAccList) {
        Set<Id> setOfPropertyIds = new Set<Id>();
        for (Account acc : newAccList) {
            setOfPropertyIds.add(acc.Property__c);
        }

        List<Property__c> properties = [Select Id, Name, Status__c From Property__c Where Id In : setOfPropertyIds];
        Map<Id, Property__c> mapOfProperties = new Map<Id, Property__c>();
        mapOfProperties.putAll(properties);

        for (Account acc : newAccList) {
            if (acc.Status__c == null) {
                Property__c prop = mapOfProperties.get(acc.Property__c);
                if (prop.Status__c != null) {
                    acc.Status__c = prop.Status__c;
                }
            }
        }
    }
}