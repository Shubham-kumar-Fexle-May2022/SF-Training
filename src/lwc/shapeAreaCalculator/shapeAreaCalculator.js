import { LightningElement , track} from 'lwc';

export default class ShapeAreaCalculator extends LightningElement {
    @track currentOutput;
    width;
    height;
    side;
    diagonal1;
    diagonal2;

    sideChangeHandler(event) {
        this.side = event.target.value;
    }
    widthChangeHandler(event) {
        this.width = event.target.value;
    }
    heightChangeHandler(event) {
        this.height = event.target.value;
    }
    diagonal1ChangeHandler(event) {
        this.diagonal1 = event.target.value;
    }
    diagonal2ChangeHandler(event) {
        this.diagonal2 = event.target.value;
    }

    calculateSqAreaHandler() {
        const s = parseInt(this.side);
        this.currentOutput = 'Are of Square is: ' + (s*s);
    }

    calculateRectAreaHandler() {
        const h = parseInt(this.height);
        const w = parseInt(this.width);
        this.currentOutput = 'Are of Rectangle is: ' + (h*w);
    }

    calculateRhAreaHandler() {
        const d1 = parseInt(this.diagonal1);
        const d2 = parseInt(this.diagonal2);
        this.currentOutput = 'Are of Rhombus is: ' + (d1*d2)/2;
    }
}