import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Property__c.Name',
    'Property__c.City__c',
    'Property__c.State__c',
    'Property__c.Location__Latitude__s',
    'Property__c.Location__Longitude__s'
];

export default class PropertyMap extends LightningElement {
    @api recordId;
    @track mapMarkers = [];

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    propertyData({ error, data }) {
        if (data) {
            const lat = data.fields.Location__Latitude__s.value;
            const lng = data.fields.Location__Longitude__s.value;
            const name = data.fields.Name.value;
            const city = data.fields.City__c.value;

            if (lat && lng) {
                this.mapMarkers = [{
                    location: { Latitude: lat, Longitude: lng, City: city },
                    title: name,
                    description: `Location of ${name}`
                }];
            }
        }
    }
}