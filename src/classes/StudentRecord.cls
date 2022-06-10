public class StudentRecord {
    
    public static void Studentdetails() {
        //For inserting the record in Student object
        Student__c student = new Student__c();
        student.Name = 'Charan Kumar';
        student.Roll_Number__c = 19055;
        student.Father_s_Name__c = 'Prem Singh';
        student.Mobile_Number__c = '9725727123';
        student.Father_Mobile_Number__c = '7253253980';
        student.Home_Phone__c = '9782734025';
        student.Email__c = 'charan.kumar@gmail.com';
        student.Address__c = 'Laxmi Nagar';
        student.City__c = 'Mathura';
        student.Overall_Grade__c = 'A';
        student.Class__c = 'BCA';
        student.X1st_Sem_Back__c = true;
        student.Subjects_In_which_Back_1st_sem__c = 'C Programming';
        student.X2nd_Sem_Back__c = false;
        student.X3rd_Sem_Back__c = false;
        student.X4th_Sem_Back__c = false;
        student.X1st_Sem_Percentage__c = 71;
        student.X2nd_Sem_Percentage__c = 75;
        student.X3rd_Sem_Percentage__c = 69;
        student.X4th_Sem_Percentage__c = 73;
        student.Exam_Fees_Submitted__c = true;
        student.Fees_Submitted__c = true;
        student.Is_Donation__c = false;
        student.Bank_Name__c = 'State Bank Of India';
        student.IFSC_Code__c = 'SBIN0001073';
        student.State__c = 'Uttar Pradesh';
        student.Stream__c = 'Commerce';
        student.Section__c = 'D';
        

        insert student;
        
        
        //Query for selecting all student record
        List<Student__c> studentList = [Select Student_ID__c, Name, Roll_Number__c, Father_s_Name__c, Email__c, State__c, Section__c, Fees_Submitted__c, Mobile_Number__c, Address__c, City__c From Student__c order by CreatedById LIMIT 5];
        for(Student__c students : studentList) {
            system.debug('Checkout Student Data:'+ students);
        }
        
        
  
    }
}