import { LightningElement , wire } from 'lwc';
import pubSub from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';

export default class SubscriberComponent extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    msg='';

    connectedCallback(){
        pubSub.registerListener('submitevent',this.handleSubmitevent,this);
    }

    disconnectedCallback() {
        pubSub.unregisterAllListeners(this);
    }

    handleSubmitevent(message){
        this.msg=message;
    }
}