const paypal = require('@paypal/checkout-server-sdk');
const logger = require('../logger/winston');
const sendError = require("../error/error-response");
const config = require('config');
const clientId = config.get('PAYMENT.PAYPAL.client_id');
const clientSecret = config.get('PAYMENT.PAYPAL.client_secret');
// This sample uses SandboxEnvironment. In production, use LiveEnvironment
let environment = new paypal.core.SandboxEnvironment(clientId, clientSecret);
let client = new paypal.core.PayPalHttpClient(environment);
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
    let request = new paypal.orders.OrdersCreateRequest();
    request.requestBody({
        intent: "CAPTURE",
        purchase_units: [
            {
                "amount": {
                    "currency_code": "USD",
                    "value": "100.00"
                }
            }
        ]
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

module.exports = { initiate, success, cancel }