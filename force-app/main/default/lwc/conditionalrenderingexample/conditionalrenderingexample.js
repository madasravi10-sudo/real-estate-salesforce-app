import { LightningElement } from 'lwc';

export default class ConditionalExample extends LightningElement {
    isVisible = false;

    showMsg() {
        this.isVisible = true;
    }
}