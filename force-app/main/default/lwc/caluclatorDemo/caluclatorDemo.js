import { LightningElement } from 'lwc';

export default class FullCaluclator extends LightningElement {
    expression='';
    result= 0;
buttons= [
    {id:1,values:[{label:'1'},{label:'2'},{label:'3'},{label:'+',variant:'brand'}]},
    {id:2,values:[{label:'4'},{label:'5'},{label:'6'},{label:'-',variant:'brand'}]},
    {id:3,values:[{label:'7'},{label:'8'},{label:'9'},{label:'*',variant:'brand'}]},
    {id:4,values:[{label:'CLR',varint:'destructive'},{label:'0'},{label:'=',variant:'success'},{label:'/',variant:'brand'}]},
];
handleButtonClick(event){
    const label =event.target.label;
    if(label== 'CLR'){
        this.expression='';
        this.result=0;
    }
    else if(label=='='){
        try{
            this.result=eval(this.expression);
        }
        catch(e){
            this.result='Error';
        } 
    }else {
        this.expression +=label;
    }
        }
        }