import { LightningElement, api } from 'lwc';

export default class ChildCompo extends LightningElement {
    @api childMessage;

    @api showalert() {
        alert('Hello from Parent!');
    }
}