import { LightningElement , track} from 'lwc';

export default class Calculator extends LightningElement {
    @track currentOutput;
    firstNumber;
    secondNumber;

    fNumberChangeHandler(event) {
        this.firstNumber = parseFloat(event.target.value);
    }

    sNumberChangeHandler(event) {
        this.secondNumber = parseFloat(event.target.value);
    }
    
    // tofixed()=> This will used for remove the digits after decimal point
    calculateAddHandler() {
        this.currentOutput = 'ADDITION = ' + parseFloat(this.firstNumber + this.secondNumber).toFixed(3);
    }

    calculateSubtractHandler() {
        this.currentOutput = 'SUBTRACTION = ' + parseFloat(this.firstNumber - this.secondNumber).toFixed(3);
    }

    calculateMultiplyHandler() {
        this.currentOutput = 'MULTIPLICATION = ' + parseFloat(this.firstNumber * this.secondNumber).toFixed(3);
    }

    calculateDivideHandler() {
        this.currentOutput = 'DIVISION = ' + parseFloat(this.firstNumber / this.secondNumber).toFixed(3); 
    }
}