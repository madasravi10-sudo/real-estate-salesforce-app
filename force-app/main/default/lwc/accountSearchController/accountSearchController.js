import { LightningElement, track } from 'lwc';
import searchAccounts from '@salesforce/apex/AccountSearchController.searchAccounts';

export default class SearchAccount extends LightningElement {

    @track accounts;
    noResult = false;

    handleSearch(event) {
        const searchKey = event.target.value;

        if (searchKey.length < 2) {
            this.accounts = null;
            this.noResult = false;
            return;
        }

        searchAccounts({ searchKey: searchKey })
            .then(result => {
                this.accounts = result;
                this.noResult = result.length === 0;
            })
            .catch(error => {
                console.error(error);
            });
    }
}