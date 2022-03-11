const config = require('config');
const logger = require('../logger/winston');
const { sendError } = require("../error/error-response");
const token = config.get('SHIPPO.TOKEN');
const shippo = require('shippo')(token);
const addressFrom = config.get('SHIPPO.ADDRESS_FROM');
const {
    SHIPPING_COST_FETCH_ERROR,
    SHIPPING_COST_INVALID_RESPONSE,
    SHIPPING_COST_FETCH_ERROR_NO_USPS_RATE,
    SHIPPING_TXN_CREATE_ERROR,
    SHIPPING_TXN_INVALID_RESPONSE
} = require("../error/errors.json");

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function fetchShippingCost(req, res, next) {
    logger.debug("Fetch shipping cost");
    const { addressTo, parcels } = req._data.middleware;
    shippo.shipment.create({
        address_from: addressFrom,
        address_to: addressTo,
        parcels,
        async: false
    }, (err, shipment) => {
        if (err) {
            return sendError(res, SHIPPING_COST_FETCH_ERROR, err);
        }
        else if (shipment.status != 'SUCCESS') {
            return sendError(res, SHIPPING_COST_INVALID_RESPONSE, { status: shipment.status });
        }
        else {
            let uspsRates = shipment.rates.filter(rate => rate.provider === 'UPS');
            if (!uspsRates || uspsRates.length === 0) {
                return sendError(res, SHIPPING_COST_FETCH_ERROR_NO_USPS_RATE);
            }
            else {
                req._data.middleware = {
                    ...req._data.middleware,
                    shipping: {
                        id: uspsRates[0].object_id,
                        shipment: uspsRates[0].shipment,
                        amount: Number(uspsRates[0].amount),
                        currency: uspsRates[0].currency
                    }
                };
                next();
            }
        }
    });
}

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function createShipment(req, res, next) {
    logger.debug("Create shipment");
    const { shipmentId } = req._data.middleware;
    if (!shipmentId) return next();
    shippo.transaction.create({
        rate: shipmentId,
        label_file_type: "PDF",
        async: false
    }, (err, transaction) => {
        let remarks;
        if (err) {
            logger.error(err);
            remarks = 'Transaction create error';
            req._data.middleware = {
                ...req._data.middleware,
                shipping: {
                    txn: {
                        remarks
                    }
                }
            };
            return next();
        }
        else {
            if (transaction.status !== 'SUCCESS') {
                logger.error(transaction.status);
                remarks = 'Transaction status is not success'
            }
            req._data.middleware = {
                ...req._data.middleware,
                shipping: {
                    txn: {
                        remarks,
                        id: transaction.object_id,
                        rate: transaction.rate,
                        trackingNo: transaction.tracking_number,
                        trackingURL: transaction.tracking_url_provider,
                        labelURL: transaction.label_url
                    }
                }
            };
            next();
        }
    });
}

module.exports = { fetchShippingCost, createShipment };