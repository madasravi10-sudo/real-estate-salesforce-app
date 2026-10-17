import { LightningElement, track, wire } from 'lwc';
import getProperties from '@salesforce/apex/PropertyListController.getProperties';

const COLUMNS = [
    { label: 'Property Name', fieldName: 'Name' },
    { label: 'City', fieldName: 'City__c' },
    { label: 'State', fieldName: 'State__c' },
    { label: 'Rent', fieldName: 'Rent__c', type: 'currency' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Furnishing', fieldName: 'Furnishing_Status__c' }
];

export default class PropertyList extends LightningElement {
    @track properties = [];
    @track columns = COLUMNS;
    @track pageNumber = 1;
    @track pageSize = 25;
    @track totalRecords = 0;

    selectedAvailability = '';
    selectedFurnishing = '';
    selectedpricerangestatus = '';
    selectednearbydistancestatus = '';

    minPrice = null;
    maxPrice = null;
    distanceKm = null;
    userLat = null;
    userLon = null;

    get availabilityOptions() {
        return [
            { label: 'All', value: '' },
            { label: 'Available', value: 'Available' },
            { label: 'Occupied', value: 'Occupied' }
        ];
    }

    get furnishingOptions() {
        return [
            { label: 'All', value: '' },
            { label: 'Furnished', value: 'Furnished' },
            { label: 'Semi-Furnished', value: 'Semi-Furnished' },
            { label: 'Unfurnished', value: 'Unfurnished' }
        ];
    }
    get pricerangeOptions() {
        return [
            { label: '10,000 -20,0000', value: '10,000 -20,000' },
            { label: '20,000-40,000', value: '20,000 -40,000' },
            { label: '40,000 -60,000', value: '40,000 -60,000' },

        ];
    }
    get nearbydistanceOptions() {
        return [
            { label: '10-20', value: '10 -20' },
            { label: '20-40', value: '20 -40' },
            { label: '40 -60', value: '40 -60' },

        ];
    }

    connectedCallback() {
        this.loadProperties();
    }

    loadProperties() {
        getProperties({
            availability: this.selectedAvailability,
            furnishing: this.selectedFurnishing,
            minPrice: this.minPrice,
            maxPrice: this.maxPrice,
            userLat: this.userLat,
            userLon: this.userLon,
            distanceKm: this.distanceKm,
            pageNumber: this.pageNumber,
            pageSize: this.pageSize
        })
            .then(result => {
                this.properties = result.properties;
                this.totalRecords = result.totalRecords;
            })
            .catch(error => {
                console.error('Error fetching properties', error);
            });
    }

    handleFilterChange(event) {
        const field = event.target.name;
        const value = event.target.value;

        if (field === 'availability') {
            this.selectedAvailability = value;
        } else if (field === 'furnishing') {
            this.selectedFurnishing = value;
        } else if (field === 'minPrice') {
            this.minPrice = value ? parseFloat(value) : null;
        } else if (field === 'maxPrice') {
            this.maxPrice = value ? parseFloat(value) : null;
        } else if (field === 'distanceKm') {
            this.distanceKm = value ? parseFloat(value) : null;
            if (this.distanceKm) {
                // Get user current location for distance filtering
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(position => {
                        this.userLat = position.coords.latitude;
                        this.userLon = position.coords.longitude;
                        this.pageNumber = 1;
                        this.loadProperties();
                    }, error => {
                        console.error('Geolocation error', error);
                    });
                    return;
                }
            } else {
                this.userLat = null;
                this.userLon = null;
            }
        }

        this.pageNumber = 1;
        this.loadProperties();
    }

    handleNext() {
        this.pageNumber += 1;
        this.loadProperties();
    }

    handlePrev() {
        if (this.pageNumber > 1) {
            this.pageNumber -= 1;
            this.loadProperties();
        }
    }

    get isFirstPage() {
        return this.pageNumber === 1;
    }

    get isLastPage() {
        return (this.pageNumber * this.pageSize) >= this.totalRecords;
    }
}