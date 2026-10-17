import { LightningElement, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

export default class ContactPagination extends LightningElement {
    @track contacts = [];
    @track paginatedContacts = [];

    page = 1;
    pageSize = 5;
    totalPages = 100;

    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            console.log('Data received from Apex:', data);
            this.contacts = data;
            this.totalPages = Math.ceil(this.contacts.length / this.pageSize);
            console.log('Total pages:', this.totalPages);
            this.updatePaginatedContacts();
            console.log('Paginated contacts:', this.paginatedContacts);
        } else if (error) {
            console.error(error);
        } else {
	    console.log('wiredContacts called, but no data or error.');
        }
    }

    updatePaginatedContacts() {
        try {
            const start = (this.page - 1) * this.pageSize;
            if (this.contacts && this.contacts.length > 0) {
                const end = start + this.pageSize;
                this.paginatedContacts = this.contacts.slice(start, end);
            } else {
                this.paginatedContacts = [];
            }
        } catch (error) {
            console.error('Error in updatePaginatedContacts:', error);
            this.paginatedContacts = []; // Ensure paginatedContacts is empty in case of error
        }
    }

    handleNext() {
        if (this.page < this.totalPages) {
            this.page++;
            this.updatePaginatedContacts();
        }
    }

    handlePrevious() {
        if (this.page > 1) {
	    console.log('Previous button clicked');
            this.page--;
            this.updatePaginatedContacts();
        }
    }
}