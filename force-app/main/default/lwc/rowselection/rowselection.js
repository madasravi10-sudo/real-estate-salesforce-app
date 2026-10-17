import { LightningElement,track} from 'lwc';
import acountlist from '@salesforce/apex/getAccountsList.acountlist';
export default class Rowselection extends LightningElement {
     @track columnsList = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Phone', fieldName: 'Phone', type: 'phone' },
        { label: 'Rating', fieldName: 'Rating', type: 'text' },
        { label: 'Industry', fieldName: 'Industry', type: 'text' }
    ];
    
    @track dataList = [];
    @track selectedRecords=[];

    connectedCallback() {
        this.getAccounts();
    }

    getAccounts(){
        acountlist()
            .then((result) => {
                console.log('Result==', result);
                this.dataList = result; // Set the data received into the dataList
                console.log('data length==' + this.dataList.length);
            })
            .catch((error) => {
                console.error('Error fetching data: ', error);
            });
   
    }
    handleRowAction(event){
        this.selectedRecords=event.detail.selectedRows;
        alert('selcted record..'+JSON.stringify(selectedRecords));
        console.log('this.selectedRecords==',JSON.stringify(selectedRecords));
        console.log('this.selectedRecords.length=='+this.selectedRecords.length);

    }

}