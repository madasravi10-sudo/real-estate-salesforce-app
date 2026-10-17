import { LightningElement, track, wire } from 'lwc';
import getTenants from '@salesforce/apex/TenantListController.getTenants';

const COLUMNS = [
    { label: 'Tenant Name', fieldName: 'Name' },
    { label: 'Phone Number', fieldName: 'Phone_Number__c', type: 'phone' },
    { label: 'Email', fieldName: 'Email__c', type: 'email' }
];

export default class TenantList extends LightningElement {
    @track tenants = [];
    @track columns = COLUMNS;

    @wire(getTenants)
    wiredTenants({ error, data }) {
        if (data) {
            this.tenants = data;
        } else if (error) {
            console.error('Error fetching tenants', error);
        }
    }
}