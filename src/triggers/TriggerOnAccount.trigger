// Trigger for deleting the Account records 

trigger TriggerOnAccount on Account (before delete, after delete, after undelete) {
    if(Trigger.isBefore){
        if(Trigger.isDelete){
           if(StaticAndInstanceMethods.firstRun){
               Trigger.old[0].addError('Before Account Delete Error');
               StaticAndInstanceMethods.firstRun=false;
            } 
         }
      }

}