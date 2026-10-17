import { LightningElement } from 'lwc';

export default class LoanEmiCalculator extends LightningElement {

    amount;
    rate;
    tenure;

    emi;
    totalInterest;
    totalPayment;

    handleAmount(event){
        this.amount = event.target.value;
    }

    handleRate(event){
        this.rate = event.target.value;
    }

    handleTenure(event){
        this.tenure = event.target.value;
    }

    calculateEmi(){

        let P = parseFloat(this.amount);
        let r = parseFloat(this.rate) / 12 / 100;
        let n = parseFloat(this.tenure) * 12;

        let emi = (P * r * Math.pow(1+r, n)) / (Math.pow(1+r, n) - 1);

        this.emi = emi.toFixed(2);

        this.totalPayment = (emi * n).toFixed(2);

        this.totalInterest = (this.totalPayment - P).toFixed(2);
    }
}