import { LightningElement } from 'lwc';
export default class DataBindingExample extends LightningElement {
name='';
handlechange
(event){
    this.name=event.target.value;
}
}