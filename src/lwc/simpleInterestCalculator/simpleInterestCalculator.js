import { LightningElement, track } from 'lwc';

export default class SimpleInterestCalculator extends LightningElement {
    @track currentOutput;
    principal;
    rateOfInterest;
    noOfYears;

    principalHandler(event) {
        this.principal = parseFloat(event.target.value);
    }
    timeChangeHandler(event) {
        this.noOfYears = parseFloat(event.target.value);
    }
    rateChangeHandler(event) {
        this.rateOfInterest = parseFloat(event.target.value);
    }
    calculateSIHandler() {
        this.currentOutput = 'Simple Interest = ' + ((this.principal * this.noOfYears * this.rateOfInterest)/100).toFixed(3);
    } 
    calculateCIHandler() {
        const amount = (this.principal * Math.pow((1 + this.rateOfInterest/100), this.noOfYears));
        this.currentOutput = 'Compound Interest = ' + (amount - this.principal).toFixed(3);
    }
}