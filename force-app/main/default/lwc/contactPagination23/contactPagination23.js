import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactPaginationController.getContacts';

const COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email', type: 'email' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class ContactPagination extends LightningElement {

    columns = COLUMNS;
    @track contacts = [];

    pageSize = 10;
    pageNumber = 1;
    offset = 0;

    @wire(getContacts, { pageSize: '$pageSize', offsetVal: '$offset' })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data;
        }
    }

    handleNext() {
        this.pageNumber++;
        this.offset = (this.pageNumber - 1) * this.pageSize;
    }

    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.offset = (this.pageNumber - 1) * this.pageSize;
        }
    }

    get disablePrevious() {
        return this.pageNumber === 1;
    }
}