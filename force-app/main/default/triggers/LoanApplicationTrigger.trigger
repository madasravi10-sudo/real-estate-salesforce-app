trigger LoanApplicationTrigger on Loan_Application__c (after update) {
    system.debug('trigger started ');
List<Loan_Payment__c> payments = new List<Loan_Payment__c>();

    for(Loan_Application__c loan : Trigger.new){
        System.debug('Processing Loan: ' + loan.Id);

        Loan_Application__c oldLoan = Trigger.oldMap.get(loan.Id);
        System.debug('Old Status: ' + oldLoan.Loan_Status__c);
        System.debug('New Status: ' + loan.Loan_Status__c);

        if(loan.Loan_Status__c == 'Approved' && oldLoan.Loan_Status__c != 'Approved'){
            System.debug('Loan Approved Condition Met');

            Integer months = Integer.valueOf(loan.Loan_Tenure_Years__c * 12);
            System.debug('Months: ' + months);

            Decimal monthlyAmount = loan.Loan_Amount__c / months;
            System.debug('Months: ' + months);


            for(Integer i=1; i<=months; i++){

                Loan_Payment__c payment = new Loan_Payment__c();

                payment.Loan_Application__c = loan.Id;
                payment.Amount__c = monthlyAmount;
                payment.Payment_Status__c = 'Pending';

                payments.add(payment);
            }
        }
    }
System.debug('Total Payments: ' + payments.size());
if(!payments.isEmpty()){
        insert payments;
        System.debug('Payments Inserted');
    }
}