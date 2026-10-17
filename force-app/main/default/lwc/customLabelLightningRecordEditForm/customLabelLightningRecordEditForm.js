import { LightningElement ,api,track } from 'lwc';

export default class CustomLabelLightningRecordEditForm extends LightningElement {
    

    @api recordId;
    @track accountName;

    handleChange(event) {
        this.accountName = event.target.value;
    }

    handleSuccess(event) {
        // Handle success logic
    }
}