import { LightningElement, api } from 'lwc';
export default class Customer360Vehicles extends LightningElement {
    @api recordId;

    vehicles = [
        {
          id:1,
          name: '2022 Toyota Rav4',
          type: 'primary'
        },
        {
          id:2,
          name:'2019 Honda Civic',
          Type: 'secondary'
         }
    ];

    paymentMethod = 'Visa ending 3847';
    nextCharge = '$99.99 on Jun 15, 2026';
}