import { LightningElement,track} from 'lwc';
import conlist from '@salesforce/apex/contactHandler.conlist';
export default class Contactlistdatatable extends LightningElement {
    @track columnsList =[
        {label:'name', fieldname:'name',type:'text'},
         {label:'firstname', fieldname:'firstname',type:'text'},
          {label:'phone', fieldname:'phone',type:'phone'},
           {label:'leadsource', fieldname:'leadsource',type:'text'},
        
    ];
   
    @track dataList=[];
    connectedCallback(){
        this.getcontacts();
        }
    getcontacts(){
        conlist()
            .then((result) => {
                console.log('Result==', result);
                this.dataList = result; // Set the data received into the dataList
                console.log('data length==' + this.dataList.length);
            })
            .catch((error) => {
                console.error('Error fetching data: ', error);
            });
    }
}