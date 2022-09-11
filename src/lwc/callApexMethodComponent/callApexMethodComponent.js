import { LightningElement} from 'lwc';
import getTextMethod1 from '@salesforce/apex/RenderMethodExample.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/RenderMethodExample.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/RenderMethodExample.getTextMethod3';

export default class CallApexMethodComponent extends LightningElement {

    message1;
    message2;
    message3;


    callApexMethod() {
        this.executeApexClassMethods();
    }

    // callApexMethod() {
    //     const promise = new promise((resolve, reject) => {
    //         setTimeout(() => {
    //             if(resolve) 
    //                 resolve('Method1 result: ' + getTextMethod1());
    //             else
    //             reject('Error!');
    //         }, 2000);
    //     });

    //     promise
    //     .then(() => {
    //         getTextMethod1()
    //         .then((result1) => {
    //             this.message1 = ('Method1 result: ' + result1);
    
    //             getTextMethod2()
    //             .then((result2) => {
    //                 this.message2 = ('Method2 result: ' + result1 + " " + result2);
    
    //                 getTextMethod3()
    //                 .then((result3) => {
    //                     this.message3 = ('Method3 result: ' + result1 + " " + result2 + " " + result3);
    //                 }).catch((error => {
    //                     console.log(error);
    //                 }));
    //             }).catch((error => {
    //                 console.log(error);
    //             }));
    //         }).catch((error) => {
    //             console.log(error);
    //         })
    //     })
    // }

    executeApexClassMethods() {
        getTextMethod1()
        .then((result1) => {
            this.message1 = ('Method1 result: ' + result1);
            getTextMethod2()
            .then((result2) => {
                this.message2 = ('Method2 result: ' + result1 + " " + result2);
 
                getTextMethod3()
                .then((result3) => {
                    this.message3 = ('Method3 result: ' + result1 + " " + result2 + " " + result3);
                }).catch((error => {
                    console.log(error);
                }));
            }).catch((error => {
                console.log(error);
            }));
        }).catch((error) => {
            console.log(error);
        })
        .finally(() => {
            console.log('thenCatchApproach done.');
        })
    } 
}