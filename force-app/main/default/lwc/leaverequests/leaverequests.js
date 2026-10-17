import { LightningElement, wire } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { refreshApex } from '@salesforce/apex';

import getLeaveRequests
    from '@salesforce/apex/LeaveRequestController.getLeaveRequests';


const COLUMNS = [

    {
        label: 'Request Id',
        fieldName: 'Name'
    },

    {
        label: 'From Date',
        fieldName: 'From_Date__c'
    },

    {
        label: 'To Date',
        fieldName: 'To_Date__c'
    },

    {
        label: 'Reason',
        fieldName: 'Reason__c'
    },

    {
        label: 'Status',
        fieldName: 'Status__c'
    },

    {
        label: 'Manager Comment',
        fieldName: 'Manager_Comment__c'
    },

    {
        type: 'button',

        typeAttributes: {

            label: 'Edit',

            name: 'edit',

            title: 'Edit',

            value: 'edit',

            disabled: {
                fieldName: 'isEditDisabled'
            }

        }

    }

];


export default class Leaverequest extends LightningElement {

    // Leave Request records

    leaveRequests = [];


    // Datatable columns

    columns = COLUMNS;


    // Wire result

    leaveRequestsWireResult;


    // Selected record Id

    selectedLeaveId;


    // Edit Modal

    showEditModal = false;


    // ==========================================
    // GET LEAVE REQUESTS
    // ==========================================

    @wire(getLeaveRequests)

    wiredLeaveRequests(result) {

        this.leaveRequestsWireResult = result;


        if (result.data) {

            this.leaveRequests =
                result.data.map(record => ({

                    ...record,

                    // Edit only Pending records

                    isEditDisabled:
                        record.Status__c !== 'Pending'

                }));


            console.log(
                'Leave Requests:',
                this.leaveRequests
            );

        }

        else if (result.error) {

            console.error(
                'Error retrieving leave requests:',
                result.error
            );

        }

    }


    // ==========================================
    // EDIT BUTTON CLICK
    // ==========================================

    handleRowAction(event) {

        const actionName =
            event.detail.action.name;


        const row =
            event.detail.row;


        if (actionName === 'edit') {

            this.selectedLeaveId =
                row.Id;


            this.showEditModal =
                true;

        }

    }


    // ==========================================
    // SAVE
    // ==========================================

    handleSubmit(event) {

        // Stop default save

        event.preventDefault();


        // Get fields

        const fields =
            event.detail.fields;


        const fromDate =
            fields.From_Date__c;


        const toDate =
            fields.To_Date__c;


        // Check dates

        if (!fromDate || !toDate) {

            this.dispatchEvent(

                new ShowToastEvent({

                    title: 'Error',

                    message:
                        'Please enter From Date and To Date',

                    variant: 'error'

                })

            );

            return;

        }


        // From Date cannot be greater than To Date

        if (fromDate > toDate) {

            this.dispatchEvent(

                new ShowToastEvent({

                    title: 'Invalid Date',

                    message:
                        'From Date cannot be greater than To Date',

                    variant: 'error'

                })

            );

            return;

        }


        // Submit record

        const form =
            this.template.querySelector(
                '[data-id="editLeaveForm"]'
            );


        form.submit(fields);

    }


    // ==========================================
    // SAVE SUCCESS
    // ==========================================

    async handleSuccess(event) {

        await refreshApex(
            this.leaveRequestsWireResult
        );


        this.showEditModal =
            false;


        this.selectedLeaveId =
            null;


        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Success',

                message:
                    'Leave request updated successfully',

                variant: 'success'

            })

        );

    }


    // ==========================================
    // SAVE ERROR
    // ==========================================

    handleError(event) {

        console.error(
            'Error updating leave request:',
            event.detail
        );


        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Error',

                message:
                    'Error updating leave request',

                variant: 'error'

            })

        );

    }


    // ==========================================
    // CANCEL
    // ==========================================

    handleCancel() {

        this.showEditModal =
            false;


        this.selectedLeaveId =
            null;

    }


    // ==========================================
    // NO RECORDS
    // ==========================================

    get NoRecordsFound() {

        return this.leaveRequests.length === 0;

    }

}