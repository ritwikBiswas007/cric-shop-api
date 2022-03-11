const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const paypal = require("../lib/payment/paypal");
const { createShipment } = require("../lib/shipping");
const config = require('config');
const clientConfig = config.get('CLIENT');

const {
    DB_ERROR_TXN_DETAIL_FETCH,
    DB_ERROR_TXN_INITIATE,
    DB_ERROR_TXN_COMPLETE,
    DB_ERROR_ORDER_COMPLETE,
    DB_ERROR_BOOKING_COMPLETE,
    DB_ERROR_SHIPPING_DETAIL_FETCH,
    DB_ERROR_SHIPMENT_INITIATE
} = require("../lib/error/errors.json");

const SQL_FETCH_TXN_DETAIL = "CALL SP_fetch_transaction_detail(?)";
const SQL_FETCH_SHIPPING_DETAIL = "CALL SP_fetch_shipping_detail(?)";
const SQL_INITIATE_TXN = "CALL SP_initiate_transaction(?,?,?)";
const SQL_COMPLETE_TXN = "CALL SP_complete_transaction(?,?,?,?)";
const SQL_COMPLETE_ORDER = "CALL SP_complete_order(?,?)";
const SQL_COMPLETE_BOOKING = "CALL SP_complete_booking(?,?)";
const SQL_INITIATE_SHIPMENT = 'CALL SP_initiate_shipment(?,?,?,?,?,?,?,?)';

/**
 * Initiate a payment
 */
router.get('/paypal/initiate',
    (req, res, next) => {
        logger.debug("Make payment");
        const { id } = req.query;
        req._data = { input: { txnId: Number(id) } };
        next();
    },
    // Find total cost
    (req, res, next) => {
        logger.debug("Fetch transaction cost");
        const { txnId } = req._data.input;
        db.query(SQL_FETCH_TXN_DETAIL, [txnId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_TXN_DETAIL_FETCH, err);
                }
                else {
                    const { total } = results[0][0];
                    req._data.middleware = {
                        total
                    };
                    next();
                }
            }
        );
    },
    paypal.initiate,
    (req, res, next) => {
        logger.debug("Initiate transaction");
        const { txnId } = req._data.input;
        const { paymentToken, paymentId, redirectUrl } = req._data.middleware;
        db.query(SQL_INITIATE_TXN, [txnId, paymentId, paymentToken],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_TXN_INITIATE, err);
                }
                else {
                    return res.redirect(redirectUrl);
                }
            }
        );
    }
);

/**
 * Paypal payment success
 */
router.get('/paypal/success',
    paypal.success,
    (req, res, next) => {
        logger.debug("Success transaction");
        const { paymentId } = req._data.input;
        const { paymentStatus, paymentError } = req._data.middleware;
        db.query(SQL_COMPLETE_TXN, [paymentId, null, paymentStatus, paymentError],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_TXN_COMPLETE, err);
                }
                else {
                    req._data.middleware = {
                        ...req._data.middleware,
                        txnId: results[0][0].id,
                        refId: results[0][0].ref_id,
                        type: results[0][0].type
                    };
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Fetch shipping detail");
        const { refId, type } = req._data.middleware;
        if (type != 'ORDER') return next();
        db.query(SQL_FETCH_SHIPPING_DETAIL, [refId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_SHIPPING_DETAIL_FETCH, err);
                }
                else {
                    req._data.middleware = {
                        ...req._data.middleware,
                        shipmentId: results[0][0].shipment_id
                    };
                    next();
                }
            }
        );
    },
    createShipment,
    // Initiate shipment
    (req, res, next) => {
        logger.debug("Initiate shipment");
        const { type, shipmentId, shipping } = req._data.middleware;
        if (type != 'ORDER') return next();
        let status = 'INITIATED';
        if (shipping.txn.remarks) status = 'FAILED';
        db.query(SQL_INITIATE_SHIPMENT,
            [shipmentId, status, shipping.txn.id, shipping.txn.rate, shipping.txn.trackingNo,
                shipping.txn.trackingURL, shipping.txn.labelURL, shipping.txn.remarks],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_SHIPMENT_INITIATE, err);
                }
                else {
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Update order");
        const { paymentStatus, refId, type } = req._data.middleware;
        if (type != 'ORDER') return next();
        let orderStatus;
        switch (paymentStatus) {
            case 'CONFIRMED':
                orderStatus = 'CONFIRMED';
                break;
            case 'CANCELLED':
                orderStatus = 'FAILED';
                break;
            case 'FAILED':
                orderStatus = 'FAILED';
                break;
            default:
                orderStatus = 'PENDING';
                break;
        };
        db.query(SQL_COMPLETE_ORDER, [refId, orderStatus],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_ORDER_COMPLETE, err);
                }
                else {
                    const redirectURL = `${clientConfig.ORDER_COMPLETION_URL}/${refId}/${orderStatus}/Order Confirmed`
                    res.redirect(redirectURL);
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Update booking");
        const { paymentStatus, refId, type } = req._data.middleware;
        if (type != 'BOOKING') return next();
        let bookingStatus;
        switch (paymentStatus) {
            case 'CONFIRMED':
                bookingStatus = 'CONFIRMED';
                break;
            case 'CANCELLED':
                bookingStatus = 'FAILED';
                break;
            case 'FAILED':
                bookingStatus = 'FAILED';
                break;
            default:
                bookingStatus = 'PENDING';
                break;
        };
        db.query(SQL_COMPLETE_BOOKING, [refId, bookingStatus],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_BOOKING_COMPLETE, err);
                }
                else {
                    const redirectURL = `${clientConfig.BOOKING_COMPLETION_URL}/${refId}/${bookingStatus}/Booking Confirmed`
                    res.redirect(redirectURL);
                }
            }
        );
    }
);

/**
 * Paypal payment failure
 */
router.get('/paypal/cancel',
    paypal.cancel,
    (req, res, next) => {
        logger.debug("Cancel transaction");
        const { paymentToken } = req._data.input;
        const { paymentStatus, paymentError } = req._data.middleware;
        db.query(SQL_COMPLETE_TXN, [null, paymentToken, paymentStatus, paymentError],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_TXN_COMPLETE, err);
                }
                else {
                    req._data.middleware = {
                        ...req._data.middleware,
                        txnId: results[0][0].id,
                        refId: results[0][0].ref_id,
                        type: results[0][0].type
                    };
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Update order");
        const { paymentStatus, refId, type } = req._data.middleware;
        if (type != 'ORDER') return next();
        let orderStatus;
        switch (paymentStatus) {
            case 'CONFIRMED':
                orderStatus = 'CONFIRMED';
                break;
            case 'CANCELLED':
                orderStatus = 'FAILED';
                break;
            case 'FAILED':
                orderStatus = 'FAILED';
                break;
            default:
                orderStatus = 'PENDING';
                break;
        };
        db.query(SQL_COMPLETE_ORDER, [refId, orderStatus],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_ORDER_COMPLETE, err);
                }
                else {
                    const redirectURL = `${clientConfig.ORDER_COMPLETION_URL}/${refId}/${orderStatus}/Order Failed`
                    res.redirect(redirectURL);
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Update booking");
        const { paymentStatus, refId, type } = req._data.middleware;
        if (type != 'BOOKING') next();
        let bookingStatus;
        switch (paymentStatus) {
            case 'CONFIRMED':
                bookingStatus = 'CONFIRMED';
                break;
            case 'CANCELLED':
                bookingStatus = 'FAILED';
                break;
            case 'FAILED':
                bookingStatus = 'FAILED';
                break;
            default:
                bookingStatus = 'PENDING';
                break;
        };
        db.query(SQL_COMPLETE_BOOKING, [refId, bookingStatus],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_BOOKING_COMPLETE, err);
                }
                else {
                    const redirectURL = `${clientConfig.BOOKING_COMPLETION_URL}/${refId}/${bookingStatus}/Booking Failed`
                    res.redirect(redirectURL);
                }
            }
        );
    }
);

module.exports = router;