import { LightningElement } from 'lwc';

export default class ChildLwc extends LightningElement {
    progress(event){
        const mycustomEvent = new CustomEvent('callpasstoparent', {
            detail: event.target.value 
        });
        this.dispatchEvent(mycustomEvent);
    }
}