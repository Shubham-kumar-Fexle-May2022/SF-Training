import { LightningElement } from 'lwc';
import getAccountsForCombobox from '@salesforce/apex/DisplayContactOppAndCase.getAccountsForCombobox';
import getContacts from '@salesforce/apex/DisplayContactOppAndCase.getContacts';
import getCases from '@salesforce/apex/DisplayContactOppAndCase.getCases';
import getOpportunities from '@salesforce/apex/DisplayContactOppAndCase.getOpportunities';
const conColumns = [
    {label : 'Contact Name', fieldName : 'Name'},
    {label : 'Contact Email', fieldName : 'Email'}
]

const oppColumns = [
    {label : 'Opportunity Name', fieldName : 'Name'},
    {label : 'Opportunity Email', fieldName : 'Email__c'}
]

const casColumns = [
    {label : 'Case Name', fieldName : 'CaseNumber'},
    {label : 'Case Email', fieldName : 'ContactEmail'}
]
export default class DisplayContactListComponent extends LightningElement {
    value = "";
    cardVisible = true;
    con = [];
    opp = [];
    cas = [];
    conColumns = conColumns;
    oppColumns = oppColumns;
    casColumns = casColumns;
    optionsArray = []; // store the option from combobox.

    get options() {
        return this.optionsArray;
    }


    connectedCallback() {
        getAccountsForCombobox()
        .then(response => {
            let arr = [];
            for(var i = 0; i < response.length; i++) {
                arr.push({label : response[i].Name, value : response[i].Id})
            }
            this.optionsArray = arr;
        })
    }

    handleChangedValue(event) {
        this.cardVisible = true;
        this.value = event.detail.value;
        getContacts({selectedAccountId : this.value})
        .then(result => {
            this.con = result;
        })
        .catch(error => {
            window.alert('error:' + error);
        })

        getOpportunities({selectedAccountId : this.value})
        .then(result => {
            this.opp = result;
        })
        .catch(error => {
            window.alert('error:' + error);
        })

        getCases({selectedAccountId : this.value})
        .then(result => {
            this.cas = result;
        })
        .catch(error => {
            window.alert('error:' + error);
        })
    }
}