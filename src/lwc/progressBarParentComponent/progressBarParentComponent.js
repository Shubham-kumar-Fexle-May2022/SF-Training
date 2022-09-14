import { LightningElement, track } from 'lwc';

export default class ParentLwc extends LightningElement {
    @track barVal;
    passToParent(event){
        this.barVal = event.detail;
    }
}