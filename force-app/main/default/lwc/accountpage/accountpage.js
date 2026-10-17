import { LightningElement, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class AccountList extends LightningElement {
    @track accounts = [];

    handleLoad() {
        getAccounts()
            .then(result => { this.accounts = result; })
            .catch(error => { console.error(error); });
    }
}