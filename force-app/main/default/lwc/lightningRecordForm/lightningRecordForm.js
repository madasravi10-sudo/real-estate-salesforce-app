import { LightningElement,api} from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
export default class LightningRecordForm extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields=[NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD,PHONE_FIELD];
    handleSubmit(event){
        this.submit=event.target.value;
    }

}