const stripe = require('stripe')('sk_test_4eC39HqLyjWDarjtT1zdp7dc');


stripe.checkout.sessions.create({
    success_url: 'https://example.com/success',
    cancel_url: 'https://example.com/cancel',
    line_items: [
        {
            //price: price.id, quantity: 1
            price_data: {
                unit_amount: 3457,
                currency: 'usd',
                product: 'abcd'
            },
            quantity: 1
        }
    ],
    mode: 'payment',
}).then(session => {
    console.log(session);
}).catch(err => {
    console.log(err);
});

/* stripe.prices.create({
    unit_amount: 2000,
    currency: 'usd',
    product: 'abcd',
})
    .then(price => {
        //console.log(price)
        stripe.checkout.sessions.create({
            success_url: 'https://example.com/success',
            cancel_url: 'https://example.com/cancel',
            line_items: [
                {
                    //price: price.id, quantity: 1
                    price_data: {
                        unit_amount: 100,
                        currency: 'usd',
                        product: 'abcd'
                    },
                    quantity: 100
                }
            ],
            mode: 'payment',
        }).then(session => {
            console.log(session);
        }).catch(err => {
            console.log(err);
        });
    })
    .catch(err => console.log(err)); */