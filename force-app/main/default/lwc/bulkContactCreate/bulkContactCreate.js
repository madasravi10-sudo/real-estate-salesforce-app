import { LightningElement, track } from 'lwc';
import createContacts from '@salesforce/apex/BulkContactController.createContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BulkContactCreate extends LightningElement {

    @track contacts = [
        { key: Date.now(), FirstName: '', LastName: '', Email: '' }
    ];

    handleChange(event) {
        const index = event.target.dataset.index;
        const field = event.target.name;
        const value = event.target.value;

        let tempContacts = [...this.contacts];
        tempContacts[index][field] = value;
        this.contacts = tempContacts;
    }

    addRow() {
        this.contacts = [
            ...this.contacts,
            {
                key: Date.now() + Math.random(), // UNIQUE KEY
                FirstName: '',
                LastName: '',
                Email: ''
            }
        ];
    }

    saveContacts() {
        createContacts({ contactsList: this.contacts })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contacts created successfully',
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error(error);
            });
    }
}