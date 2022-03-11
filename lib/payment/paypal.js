const paypal = require('paypal-rest-sdk');
const logger = require('../logger/winston');
const sendError = require("../error/error-response");
const config = require('config');
const paypalConfig = config.get('PAYMENT.PAYPAL');
const {
    PAYPAL_PAYMENT_INITIATE_ERROR
} = require("../error/errors.json");

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function initiate(req, res, next) {
    logger.debug("Initiate Paypal payment");
    const { total, description } = req._data.middleware;
    const paymentData = {
        intent: 'sale',
        payer: {
            payment_method: 'paypal'
        },
        redirect_urls: {
            return_url: paypalConfig.RETURN_URL,
            cancel_url: paypalConfig.CANCEL_URL
        },
        transactions: [{
            amount: {
                //total: String(Math.ceil(total)),
                total: String(1),
                currency: "USD"
            },
            description: description ? description : "US Cricket store online payment"
        }]
    };
    // set the config
    paypal.configure(paypalConfig.CONFIG);
    // create payment
    paypal.payment.create(paymentData, (err, payment) => {
        if (err) {
            return sendError(res, PAYPAL_PAYMENT_INITIATE_ERROR, err);
        }
        else if (payment.payer.payment_method === 'paypal') {
            let paymentToken;
            let redirectUrl;
            for (let i = 0; i < payment.links.length; i++) {
                const link = payment.links[i];
                if (link.method === 'REDIRECT') {
                    redirectUrl = link.href;
                    paymentToken = link.href.substring(link.href.indexOf('&token=') + 7);
                    break;
                }
            }
            req._data.middleware = { ...req._data.middleware, paymentId: payment.id, paymentToken, redirectUrl };
            next();
        }
    });
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function success(req, res, next) {
    logger.debug("Paypal payment success callback");
    const { paymentId, token } = req.query;
    const payerId = req.query.PayerID;
    paypal.payment.execute(paymentId, { payer_id: payerId }, (err, payment) => {
        let paymentStatus = 'FAILED', paymentError;
        if (err) {
            paymentError = err.response.name ? err.response.name : err.message;
        }
        else {
            // successful payment
            if (payment.state === 'approved') {
                paymentStatus = 'CONFIRMED';
                logger.debug(payment);
                logger.debug(JSON.stringify(payment));
            } else if (payment.failureReason) {
                paymentError = err.response.name
            } else {
                paymentError = 'Payment status unknown';
            }
        }
        req._data = {
            input: { paymentId },
            middleware: { paymentStatus, paymentError }
        };
        next();
    });
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function cancel(req, res, next) {
    logger.debug("Paypal payment cancel callback");
    req._data = {
        input: { paymentToken: req.query.token },
        middleware: { paymentStatus: 'CANCELLED', paymentError: 'User has cancelled the payment' }
    };
    next();
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function refund(req, res, next) {
    logger.debug("Paypal initiate refund");
    // set the config
    paypal.configure(paypalConfig.CONFIG);
    paypal.sale.refund('6X336185PV0587939', {
        amount: {
            currency: 'USD',
            total: "1"
        }
    }, (err, refund) => {
        if (err) {
            logger.error('Error while initiating refund', err);
        }
        else {
            logger.debug('Successfully initiated refund', refund);
        }
        next();
    });
}

module.exports = { initiate, success, cancel, refund }