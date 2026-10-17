import { LightningElement,api} from 'lwc';

export default class LightningRecordEditForm extends LightningElement {
    @api recordId;
    handleSucess(event){
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Record saved successfully!',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}