import { LightningElement } from 'lwc';
import sighinTemplate from './sighinTemplate.html'
import sighupTemplate from './signupTemplate.html'
import defaultTemplate from './multiplerenderdemo.html'
export default class Multiplerenderdemo extends LightningElement {

    selected =null;

    render(){
        return this.selected== 'sigh up' ? sighupTemplate:
        this.selected=='sigh in' ? sighinTemplate:
        defaultTemplate 
    

    }
handleclick(event){
    this.selected=event.target.label;
}



}