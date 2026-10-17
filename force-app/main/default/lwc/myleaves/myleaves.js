import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getMyLeaves from '@salesforce/apex/LeaveRequestController.getMyLeaves';
import { refreshApex } from '@salesforce/apex';
import USER_ID from '@salesforce/user/Id';
const COLUMNS = [
    {
        label: 'Request Id',
        fieldName: 'Name',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Start Date',
        fieldName: 'From_Date__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'To Date',
        fieldName: 'To_Date__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Reason',
        fieldName: 'Reason__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Status',
        fieldName: 'Status__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        label: 'Manager Comment',
        fieldName: 'Manager_Comment__c',
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    },
    {
        type: 'button',
        typeAttributes: {
            label: 'Edit',
            name: 'edit',
            title: 'Edit',
            value: 'edit',
            disabled: { fieldName: 'isEditDisabled' }
        },
        cellAttributes: {
            class: { fieldName: 'cellClass' }
        }
    }
];

export default class Myleaves extends LightningElement {

    myLeaves = [];
    myLeavesWireResult;
    columns = COLUMNS;
    showEditModal = false;
    selectedLeaveId;
    objectapiname = 'Leave_Request__c';
    showNewLeaveModal = false;

    currentUserId = USER_ID;

    @wire(getMyLeaves)
    wiredMyLeaves(result) {

        this.myLeavesWireResult = result;

        if (result.data) {

            this.myLeaves = result.data.map(a => ({

                ...a,

                 cellClass:
        a.Status__c === 'Approved'
            ? 'slds-theme_success'
            : a.Status__c === 'Rejected'
                ? 'slds-theme_warning'
                : '',

    isEditDisabled: a.Status__c !== 'Pending'
            }));

            console.log('My Leaves:', this.myLeaves);

        } else if (result.error) {

            console.error(
                'Error retrieving my leaves:',
                result.error
            );
        }
    }

    handleNewLeave() {

    this.showNewLeaveModal = true;

}
   handleNewCancel() {

    this.showNewLeaveModal = false;

}

async handleNewSuccess(event) {

    await refreshApex(this.myLeavesWireResult);

    this.showNewLeaveModal = false;

    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Success',
            message: 'Leave created successfully',
            variant: 'success'
        })
    );

}

  handleNewError(event) {

    console.error(
        'Error creating leave:',
        event.detail
    );

    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Error',
            message: 'Error creating leave',
            variant: 'error'
        })
    );

}

    handleRowAction(event) {

    const actionName = event.detail.action.name;
    const row = event.detail.row;

    if (actionName === 'edit') {

        this.selectedLeaveId = row.Id;

        this.showEditModal = true;

    }
}
    handleCancel() {

    this.showEditModal = false;
    this.selectedLeaveId = null;

}

  handleError(event) {

    console.error('Error updating leave:', event.detail);

}
   handleSuccess(event) {

    this.showEditModal = false;
    this.selectedLeaveId = null;

    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Success',
            message: 'Leave updated successfully',
            variant: 'success'
        })
    );
}
    

    get NoRecordsFound() {
        return this.myLeaves.length === 0;
    }

     handleNewSubmit(event) {

    // Stop default save first
    event.preventDefault();

    const fields = event.detail.fields;

    const fromDate = fields.From_Date__c;
    const toDate = fields.To_Date__c;


    // Check dates are entered
    if (!fromDate || !toDate) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'Please enter From Date and To Date',
                variant: 'error'
            })
        );

        return;
    }


    // From Date > To Date
    if (fromDate > toDate) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Invalid Date',
                message: 'From Date cannot be greater than To Date',
                variant: 'error'
            })
        );

        return;
    }


    // From Date <= To Date
    // Save the record
    this.template
        .querySelector('lightning-record-edit-form')
        .submit(fields);
}
}