import { LightningElement, wire } from 'lwc';
import pubSub from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';
export default class PublisherComponent2 extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    message='';
    handleChange(event){
        this.message=event.target.value;
 }
    handleSubmit(){
        pubSub.fireEvent(this.pageRef,'submitevent',this.message);

    }
}