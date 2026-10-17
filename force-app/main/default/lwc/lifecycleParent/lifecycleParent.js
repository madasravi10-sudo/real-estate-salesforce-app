import { LightningElement } from 'lwc';

export default class LifecycleParent extends LightningElement {
    constructor(){
        super();
        console.log(' parent constructor called');
    }
   connectedCallback(){
    console.log('parent connectedcalback called');
   }
   renderedCallback(){
    console.log('parent renderedcallback');
   }
   errorCallback(error,stack){
    this.error=error;
    console.log('parent errorcallback called');
   }
   disconnectedCallback(){
    console.log('parent disconnectedcallback called');
   }
}