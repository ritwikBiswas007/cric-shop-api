const stripe = require('stripe')('sk_test_4eC39HqLyjWDarjtT1zdp7dc');
const logger = require('../logger/winston');
const sendError = require("../error/error-response");
const config = require('config');
const stripeConfig = config.get('PAYMENT.STRIPE');
const {
    STRIPE_PAYMENT_INITIATE_ERROR
} = require("../error/errors.json");

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function initiate(req, res, next) {
    logger.debug("Initiate Stripe payment");
    const { total, description } = req._data.middleware;
    const paymentData = {
        success_url: stripeConfig.RETURN_URL,
        cancel_url: stripeConfig.CANCEL_URL,
        line_items: [
            {
                //price: price.id, quantity: 1
                price_data: {
                    unit_amount: total,
                    currency: 'usd',
                    product: description
                },
                quantity: 1
            }
        ],
        mode: 'payment',
    };
    // create payment
    stripe.checkout.sessions.create(paymentData).then(session => {
        req._data.middleware = { ...req._data.middleware, paymentId: session.id, paymentToken: session.payment_intent, redirectUrl: session.url };
        next();
    }).catch(err => {
        return sendError(res, STRIPE_PAYMENT_INITIATE_ERROR, err);
    });
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function success(req, res, next) {
    logger.debug("Stripe payment success callback");
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function cancel(req, res, next) {
}

module.exports = { initiate, success, cancel }