var paypal = require('paypal-rest-sdk');
var express = require('express');
var app = express();

paypal.configure({
    'mode': 'sandbox', //sandbox or live
    'client_id': 'AXAms2-mb2OYz1DW7_zwiV1w-jcxk7Zh8X6R3hVEdRjHmEuI-KV5Pw6gNF9o5pCBow52tEl-XZN1QMgJ',
    'client_secret': 'ELXnV5Y48vqspIVU3IkETmPvtCvITxpu7EIrhJ5bEq1i3hurEqpKquVFSZmNoFnNK0Wn9lC4vS8s8wd-'
});


app.get('/pay',(req,res)=>{
    var create_payment_json = {
    "intent": "sale",
    "payer": {
        "payment_method": "paypal"
    },
    "redirect_urls": {
        "return_url": "http://10.0.2.2:8000/sucess", //for emulator
       // "return_url": "http://localhost:8000/sucess",
        "cancel_url": "http://10.0.2.2:8000/cancel" //try for emulator
       //"cancel_url": "http://cancel.url"
        //"cancel_url": "http://localhost:8000/cancel",

    },
    "transactions": [{
        "item_list": {
            "items": [{
                "name": "item",
                "sku": "item",
                "price": "1.00",
                "currency": "USD",
                "quantity": 1
            }]
        },
        "amount": {
            "currency": "USD",
            "total": "1.00"
        },
        "description": "This is the payment description."
    }]
};

paypal.payment.create(create_payment_json, function (error, payment) {
    if (error) {
        return 'error';
    } else {
        console.log("Create Payment Response");
        console.log(payment);
        for (let i=0; i<payment.links.length;i++){
            if(payment.links[i].rel=="approval_url")
            {
                res.redirect(payment.links[i].href);
            }
        }
    }
});
})

app.get('/success',(req,res)=>
{
    var execute_payment_json = {
        "payer_id": req.query.payerID,//check payerID from the request url (may be wrong)
        "transactions": [{
            "amount": {
                "currency": "USD",
                "total": "1.00" //change the value to the real price
            }
        }]
    };

    var paymentId = req.query.paymentId;//check paymentId from the request url (may be wrong)

    paypal.payment.execute(paymentId, execute_payment_json, function (error, payment) {
        if (error) {
            console.log(error.response);
            throw error;
        } else {
            console.log("Get Payment Response");
            console.log(JSON.stringify(payment));
        }
    });
})
app.listen(8000,'127.0.0.1', (req,res)=>{
    console.log('server started')
});



