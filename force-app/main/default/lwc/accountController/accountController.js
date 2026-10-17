import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/accountController2.GetAccounts';

const COLUMNS = [
    { label: 'Account Name', fieldName: 'Name', type: 'text' },
    { label: 'Industry', fieldName: 'Industry', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' }
];

export default class AccountList extends LightningElement {
    columns = COLUMNS;

    @wire(getAccounts)
    accounts;
}