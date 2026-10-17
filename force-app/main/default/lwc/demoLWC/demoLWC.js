import { LightningElement,track} from 'lwc';

export default class DemoLWC extends LightningElement {
    @track message;
    message="hi good morning";
    handleChange(event){
        this.message=event.target.value;

    }
    
}