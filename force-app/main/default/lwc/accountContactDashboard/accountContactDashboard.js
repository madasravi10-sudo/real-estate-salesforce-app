import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountContactController.getContacts';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class AccountContactDashboard extends LightningElement {
    @api recordId; // Account Id from record page
    columns = COLUMNS;
    contacts;
    wiredResult;

    @wire(getContacts, { accountId: '$recordId' })
    wiredContacts(result) {
        this.wiredResult = result;
        if (result.data) {
            this.contacts = result.data;
        }
    }

    refreshData() {
        refreshApex(this.wiredResult);
    }
}