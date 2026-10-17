import { LightningElement, wire } from 'lwc';
// Import the message channel
import LMS_MESSAGE from '@salesforce/messageChannel/MyMessageChannel__c';
// Import the publish function and MessageContext
import { publish, MessageContext } from 'lightning/messageService';

export default class LMSComponentA extends LightningElement {
    // Wire the MessageContext to use LMS functions
    @wire(MessageContext)
    messageContext;

    // Handler for input change event
    handleChange(event) {
        // Publish the input value to the message channel
        publish(this.messageContext, LMS_MESSAGE, {
            messageToSend: event.target.value
        });
    }
}