const express = require('express');
const router = express.Router();
const paypal = require('../lib/payment/paypal');

router.get('/create',
    (req, res, next) => {
        req._data = { middleware: { total: 1, description: 'test' } };
        next();
    },
    paypal.initiate,
    (req, res) => {
        const { paymentId, paymentToken, redirectUrl } = req._data.middleware;
        res.json({ paymentId, paymentToken, redirectUrl });
    },
);

router.get('/success',
    paypal.success,
    (req, res) => {
        res.sendStatus(200);
    },
);

router.get('/refund',
    paypal.refund,
    (req, res) => {
        res.sendStatus(200);
    },
);

module.exports = router;
