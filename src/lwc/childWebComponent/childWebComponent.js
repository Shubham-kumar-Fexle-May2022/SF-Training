import { LightningElement, api} from 'lwc';

export default class ChildWebComponent extends LightningElement {

    message = 'Good Morning';
    @api callChildMethod() {
        this.message = 'Good Night!! I am changed!';
        alert('This is inside the child component method!!');
    }
}