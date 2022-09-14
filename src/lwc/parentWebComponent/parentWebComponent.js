import { LightningElement } from 'lwc';

export default class ParentWebComponent extends LightningElement {

    handleClick() {
        //Calling child method
        this.template.querySelector("c-child-web-component").callChildMethod();
    }
}