import { LightningElement } from 'lwc';

export default class ImpairPayment extends LightningElement {

    hasRendered = false; // better name, non-reactive usage

    showEPCModal = true;
    rvndrEndpointUrl = 'https://httpbin.org/post';
    rvndrP = {};

    connectedCallback() {
        console.log('connectedCallback fired');

        this.rvndrP = {
            custId: 'CUST001',
            empId: 'EMP123',
            districtOffice: 'Hyderabad',
            section: 'Finance',
            sectionNo: 'SEC01',
            userId: 'USER001',
            clubCode: 'CLUB01',
            userClubCode: 'UCLUB01',
            source: 'WEB',
            secured: 'true',
            ersamt: '1000',
            paymenttype: 'CARD',
            paymentoption: 'FULL',
            allowMemPaymt: 'Y'
        };
    }

    renderedCallback() {
        if (this.hasRendered) {
            return;
        }

        this.hasRendered = true;

        console.log('renderedCallback fired ONCE');

        const form = this.template.querySelector('.epcForm');

        if (form) {
            console.log('Submitting form...');
            form.submit();
            this.showEPCModal = false;
        } else {
            console.log('Form not found');
            
        }
    }

    handleClick() {
        this.showEPCModal = false;
    }
}