import { LightningElement, api, wire, track } from 'lwc';

import getEscalationCases
    from '@salesforce/apex/EscalationController.getEscalationCases';

export default class escalationCard1 extends LightningElement {

    @api recordId;

    @track escalationCases = [];

    @track showEscalation = false;

    @track showModal = false;

    @track selectedCase = {};

    error;

    // Fetch escalation cases
    @wire(getEscalationCases, { accountId: '$recordId' })
    wiredCases({ data, error }) {

        if (data) {

            this.escalationCases = data;

            this.showEscalation = data.length > 0;

            if (data.length > 0) {
                this.selectedCase = data[0];
            }

            this.error = undefined;

        } else if (error) {

            this.error = error;

            this.escalationCases = [];

            this.showEscalation = false;

            console.error('Error fetching escalation cases', error);
        }
    }

    // Open popup modal
    openModal() {

        this.showModal = true;
    }

    // Close popup modal
    closeModal() {

        this.showModal = false;
    }
}