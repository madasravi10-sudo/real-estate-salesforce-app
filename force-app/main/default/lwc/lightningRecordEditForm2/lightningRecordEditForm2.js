import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// Import schema references for a more robust component
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class LightningRecordEditForm2 extends LightningElement {
    // Public properties to receive recordId and objectApiName from the record page
    @api recordId;
    @api objectApiName;

    // Exposing field imports to the template
    nameField = NAME_FIELD;
    phoneField = PHONE_FIELD;
    industryField = INDUSTRY_FIELD;

    // Optional: Handle the submit event
    handleSubmit(event) {
        console.log('Form submitted');
    }

    // Handle the success event and show a toast message
    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Record updated successfully!',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}