import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountValidationForm extends LightningElement {
    handleSubmit(event) {
        event.preventDefault(); // Prevent default form submission

        const fields = event.detail.fields;
        const annualRevenue = fields.AnnualRevenue;

        if (annualRevenue < 10000) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Validation Error',
                    message: 'Annual Revenue must be greater than $10,000.',
                    variant: 'error'
                })
            );
        } else {
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
    }

    handleSuccess() {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Account record saved successfully!',
                variant: 'success'
            })
        );
    }
}