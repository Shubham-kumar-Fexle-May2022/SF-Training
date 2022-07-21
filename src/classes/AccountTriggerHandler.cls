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
        *    @return         :       void (Nohting)
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
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  20/07/2022  - Shubham Kumar  
        *                                    
    */ 

    public static void addAccountNumberWithType(List<Account> accList) {
        Integer randomNumber = Integer.valueOf(Math.random() * 10000); // Generate a random number for AccountNumber.
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
        *    @return         :       void (Nohting)
        *
        *    @revision Log   :       V1.1  - Created  -  20/07/2022 - Shubham kumar  
        *                                    
    */
    
    public static void insertAndUpdateRecord(List<Account> accList) {
        for(Account acc : accList) {
            // If we insert a new record then it will execute.
            If(Trigger.isInsert) {
                acc.Phone = '9685743251'; 
                acc.Industry = 'Banking';  // Aotomatic populate at the time of account saved.
                acc.Description = 'Account Created Successfully ' + userInfo.getUserNAme();
                System.debug('Check Insert List:: Trigger.New ' + Trigger.New);
                System.debug('Check Insert List:: Trigger.Old ' + Trigger.Old);
            }
            // If we update an existing record then it will execute.
            If(Trigger.isUpdate) {
                acc.Phone = '9765324152';
                acc.Industry = 'Agriculture';
                acc.Rating = 'Hot';
                acc.Website = 'www.fexle.com';
                acc.Description = 'Account Updated Successfully ' + userInfo.getUserNAme();
                System.debug('Check Update List ::: Trigger.New ' + Trigger.New);
                System.debug('Check Update List ::: Trigger.old ' + Trigger.old);
            }
        }
    }
}