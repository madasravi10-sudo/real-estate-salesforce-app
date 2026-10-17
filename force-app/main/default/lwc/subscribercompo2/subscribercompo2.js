import { LightningElement, wire } from 'lwc';
// Import the message channel
import LMS_MESSAGE from '@salesforce/messageChannel/MyMessageChannel__c';
// Import LMS functions
import {
    subscribe,
    unsubscribe,
    MessageContext
} from 'lightning/messageService';

export default class LMSComponentB extends LightningElement {
    // Property to hold the received message
    value="not yet received";
    // Property to hold the subscription object
    subscription = null;

    // Wire the MessageContext to use LMS functions
    @wire(MessageContext)
    messageContext;
    
    // Lifecycle hook that runs when the component is inserted into the DOM
    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    // Lifecycle hook that runs when the component is removed from the DOM
    disconnectedCallback() {
        this.unsubscribeFromMessageChannel();
    }

    // Method to subscribe to the message channel
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                LMS_MESSAGE,
                (message) => (this.value = message.messageToSend)
            );
        }
    }

    // Method to unsubscribe from the message channel
    unsubscribeFromMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}