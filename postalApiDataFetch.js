import { LightningElement, track, api } from 'lwc';
import getPostalData from '@salesforce/apex/PostalApi.IndiaPostall';
export default class PostalApiDataFetch extends LightningElement {
    @track Pincode = '';
    @track postalData;
    @track error;
    columns = [
        { label: 'PostOffice Name', fieldName: 'Name' },
        { label: 'Pincode', fieldName: 'Pincode' },
        { label: 'District', fieldName: 'District' },
        { label: 'State', fieldName: 'State' },
        { label: 'Country', fieldName: 'Country' },
        { label: 'Division', fieldName: 'Division' }
    ];

    handleInputChange(event) {
        this.Pincode = event.target.value;
        console.log('your entered pincode...' + this.Pincode);

    }
    handleSearchClick() {
        console.log('line 22 '+this.Pincode);
        getPostalData({ pincode: this.Pincode })
            .then(result => {
                this.postalData = result;
                this.error = undefined;
                console.log(this.postalData);

            })
            .catch( error => {
                this.error = error.body.message;
                this.postalData = undefined;

            });

    }


}