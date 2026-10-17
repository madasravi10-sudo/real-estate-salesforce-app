import { LightningElement, track } from 'lwc';

export default class ContactList extends LightningElement {

    @track contacts = [];

    error;

    constructor() {

        super();

        console.log('Constructor called');

    }

    connectedCallback() {

        console.log('connectedCallback called');

        // Simulate API call

        this.fetchContacts();

    }

    renderedCallback() {

        console.log('renderedCallback called');

    }

    disconnectedCallback() {

        console.log('disconnectedCallback called');

    }

    fetchContacts() {

        // Simulate data fetching

        this.contacts = [

            { Id: '1', Name: 'John Doe', Email: 'john@example.com' },

            { Id: '2', Name: 'Jane Smith', Email: 'jane@example.com' },

        ];

        // Uncomment for error test

        // this.error = 'Failed to load contacts.';

    }

}