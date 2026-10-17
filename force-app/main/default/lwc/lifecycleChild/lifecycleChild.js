import { LightningElement } from 'lwc';

export default class LifecycleChild extends LightningElement {
    constructor(){
        super();
        console.log('child constructor called');
    }
    connectedCallback(){
        console.log('child connectedcalback called');
       }
       renderedCallback(){
        console.log('child renderedcallback');
       }
       errorCallback(error,stack){
        this.error=error;
        console.log('child errorcallback called');
       }
       disconnectedCallback(){
        console.log('child disconnectedcallback called');
       }
    
}