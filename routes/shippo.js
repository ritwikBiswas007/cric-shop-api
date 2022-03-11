const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const template = require("../lib/notification/template");
const { sendMail } = require("../lib/notification/email");
const { sendSMS } = require("../lib/notification/sms");
const { sendError } = require("../lib/error/error-response");

const SQL_FETCH_ORDER_ADDRESS = 'CALL SP_fetch_order_address(?)';

router.post('/track_updated',
    (req, res, next) => {
        logger.debug("Track updated webhook requested");
        let { trackUpdated } = req.body;
        req._data = {
            input: {
                shippingStatus: trackUpdated.data.tracking_status.status,
                trackingNo: trackUpdated.data.tracking_status.tracking_number
            }
        }
        next();
    },
    (req, res, next) => {
        logger.debug("Fetch order address using tracking no");
        const { trackingNo } = req._data.input;
        db.query(SQL_FETCH_ORDER_ADDRESS, [trackingNo],
            (err, results) => {
                if (err) {
                    // TODO
                    logger.error("Failed to fetch address while updating shipment status");
                    res.sendStatus(200);
                }
                else {
                    if (!results[0].length) {
                        logger.error("No Address matched");
                        res.sendStatus(200);
                    }
                    req._data.middleware = {
                        mobile: {
                            no: results[0][0].mobile_no,
                            countryCode: results[0][0].country_code
                        },
                        email: results[0][0].email
                    }
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Create email and sms content");
        const { shippingStatus } = req._data.input;
        const { mobile, email } = req._data.input;
        let mail, sms;
        switch (shippingStatus) {
            default:
                mail = {
                    ...template['ORDER_COMPLETION']['MAIL'],
                    to: `${email}`
                };
                sms = {
                    ...template['ORDER_COMPLETION']['SMS'],
                    to: `${mobile.countryCode}${mobile.no}`
                };
                break;
        }
        req._data.middleware = { ...req._data.middleware, email, sms };
        next();
    },
    sendMail,
    sendSMS,
    (req, res, next) => {
        res.sendStatus(200);
    }
);

router.get('/test',
    (req, res, next) => {
        logger.debug("Create email and sms content");
        const mobile = {
            no: 9007723255,
            countryCode: '+91'
        };
        const mail = 'ritwik.coolboy@gmail.com';
        let email, sms;

        email = {
            ...template['BOOKING_COMPLETION']['MAIL'],
            to: `${mail}`
        };
        sms = {
            ...template['ORDER_COMPLETION']['SMS'],
            to: `${mobile.countryCode}${mobile.no}`
        };

        req._data = { middleware: { email, sms } };
        next();
    },
    sendMail,
    //sendSMS,
    (req, res, next) => {
        res.sendStatus(200);
    }
);

module.exports = router;