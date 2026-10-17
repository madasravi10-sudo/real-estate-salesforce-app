import { LightningElement, track } from 'lwc';

export default class DependentPicklist extends LightningElement {

    // Selected values
    selectedCountry;
    selectedState;
    selectedCity;

    // Country options
    countryOptions = [
        { label: 'India', value: 'India' },
        { label: 'USA', value: 'USA' }
    ];

    // Data mapping
    countryStateMap = {
        India: [
            { label: 'Telangana', value: 'Telangana' },
            { label: 'Andhra Pradesh', value: 'Andhra Pradesh' }
        ],
        USA: [
            { label: 'California', value: 'California' },
            { label: 'Texas', value: 'Texas' }
        ]
    };

    stateCityMap = {
        Telangana: [
            { label: 'Hyderabad', value: 'Hyderabad' },
            { label: 'Warangal', value: 'Warangal' }
        ],
        'Andhra Pradesh': [
            { label: 'Vijayawada', value: 'Vijayawada' },
            { label: 'Visakhapatnam', value: 'Visakhapatnam' }
        ],
        California: [
            { label: 'Los Angeles', value: 'Los Angeles' },
            { label: 'San Francisco', value: 'San Francisco' }
        ],
        Texas: [
            { label: 'Dallas', value: 'Dallas' },
            { label: 'Austin', value: 'Austin' }
        ]
    };

    // Dynamic options
    @track stateOptions = [];
    @track cityOptions = [];

    // When country changes
    handleCountryChange(event) {
        this.selectedCountry = event.target.value;

        this.stateOptions = this.countryStateMap[this.selectedCountry];
        this.cityOptions = [];

        this.selectedState = null;
        this.selectedCity = null;
    }

    // When state changes
    handleStateChange(event) {
        this.selectedState = event.target.value;

        this.cityOptions = this.stateCityMap[this.selectedState];
        this.selectedCity = null;
    }
}