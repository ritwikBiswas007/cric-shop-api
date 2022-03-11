const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const { fetchShippingCost } = require("../lib/shipping");
const {
    SHIPPING_INVALID_ADDRESS_ID,
    SHIPPING_NAME_MISSING,
    SHIPPING_MOBILE_MISSING,
    SHIPPING_STREET_MISSING,
    SHIPPING_CITY_MISSING,
    SHIPPING_STATE_MISSING,
    SHIPPING_COUNTRY_MISSING,
    SHIPPING_ZIP_MISSING,
    NO_ITEMS_IN_BASKET_FOR_CHECKOUT,
    DB_ERROR_USER_ADDRESS_FETCH,
    DB_ERROR_USER_ADDRESS_CREATE,
    DB_ERROR_CART_FETCH,
    DB_ERROR_USER_ORDER_CREATE,
    DB_ERROR_USER_ORDER_BOOK_FILL,
    DB_ERROR_SHIPMENT_CREATE
} = require("../lib/error/errors.json");

const SQL_FETCH_USER_ADDRESS_DETAIL = 'CALL SP_fetch_user_address_detail(?)';
const SQL_CREATE_USER_ADDRESS = 'CALL SP_create_user_address(?,?,?,?,?,?,?,?,?,?,?)';
const SQL_FETCH_BASKET = 'CALL SP_fetch_basket(?)';
const SQL_CREATE_USER_ORDER = 'CALL SP_create_user_order(?,?,?,?,?,?,?,?)';
const SQL_CREATE_SHIPMENT = 'CALL SP_create_shipment(?,?,?,?,?,?)';
const SQL_CREATE_TXN = "CALL SP_create_transaction(?,?,?,?)";

router.post('/',
    validateToken,
    (req, res, next) => {
        logger.debug("Fetch user inputs");
        let { addressId, name, mobile, email, street1, city, state, zip, country } = req.body;
        req._data.input = { addressId, name, mobile, email, street1, city, state, zip, country };
        // TODO add validation
        if (!addressId) {
            if (!name) return sendError(res, SHIPPING_NAME_MISSING);
            if (!mobile) return sendError(res, SHIPPING_MOBILE_MISSING);
            if (!street1) return sendError(res, SHIPPING_STREET_MISSING);
            if (!city) return sendError(res, SHIPPING_CITY_MISSING);
            if (!state) return sendError(res, SHIPPING_STATE_MISSING);
            if (!country) return sendError(res, SHIPPING_COUNTRY_MISSING);
            if (!zip) return sendError(res, SHIPPING_ZIP_MISSING);
        }
        next();
    },
    (req, res, next) => {
        logger.debug("Fetch user cart detail");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_BASKET, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_CART_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, NO_ITEMS_IN_BASKET_FOR_CHECKOUT);
                    else next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Fetch user address");
        const { addressId } = req._data.input;
        if (!addressId) return next();
        db.query(SQL_FETCH_USER_ADDRESS_DETAIL, [addressId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ADDRESS_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, SHIPPING_INVALID_ADDRESS_ID);
                    req._data.middleware = {
                        ...req._data.middleware,
                        addressTo: {
                            name: results[0][0].name,
                            mobile: {
                                countryCode: results[0][0].country_code,
                                no: results[0][0].mobile_no
                            },
                            email: results[0][0].email,
                            street1: results[0][0].street1,
                            city: results[0][0].city,
                            state: results[0][0].state,
                            country: results[0][0].country,
                            zip: results[0][0].zip_code
                        }
                    };
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Create user address");
        const { addressId, name, mobile, email, street1, city, state, zip, country } = req._data.input;
        const { userId } = req._data.middleware;
        if (addressId) return next();
        db.query(SQL_CREATE_USER_ADDRESS, [userId, name, mobile.countryCode, mobile.no, email, street1, null, city, state, country, zip],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ADDRESS_CREATE, err);
                }
                else {
                    req._data.input.addressId = results[0][0].address_id;
                    req._data.middleware = {
                        ...req._data.middleware,
                        addressTo: {
                            name, mobile, email, street1, city, state, zip, country
                        }
                    };
                    next();
                }
            }
        );
    },
    //Prepare package
    (req, res, next) => {
        logger.debug("Prepare Package");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_BASKET, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_CART_FETCH, err);
                }
                else {
                    const parcels = results[0].map(({ length, height, width, weight, quantity }) => {
                        return {
                            length: length ? length : 1,
                            width: width ? width : 1,
                            height: height ? height : 1,
                            distance_unit: "cm",
                            weight: weight ? weight * quantity : 1,
                            mass_unit: "g"
                        }
                    });
                    let orderBook = results[0].map(({ variation_id, sale_price, quantity }) => {
                        return {
                            variationId: variation_id, salePrice: sale_price, quantity
                        }
                    });
                    const productCost = results[0].reduce((pv, cv) => pv += cv.sale_price * cv.quantity, 0);
                    req._data.middleware = {
                        ...req._data.middleware,
                        orderBook,
                        productCost,
                        productDiscount: 0,
                        parcels
                    }
                    next();
                }
            }
        );
    },
    fetchShippingCost,
    //Create new order
    (req, res, next) => {
        logger.debug("Create new order");
        const { userId, productCost, productDiscount, shipping } = req._data.middleware;
        const price = productCost - productDiscount + shipping.amount - 0;
        const discount = 0;
        const priceAfterDiscount = price - discount;
        db.query(SQL_CREATE_USER_ORDER, [userId, productCost, productDiscount, shipping.amount, 0, price, discount, priceAfterDiscount],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ORDER_CREATE, err);
                }
                else {
                    req._data.middleware = { ...req._data.middleware, orderId: results[0][0].order_id, totalCost: priceAfterDiscount };
                    next();
                }
            }
        );
    },
    //Fill order book
    (req, res, next) => {
        logger.debug("Fill order book");
        const { orderId, userId, orderBook } = req._data.middleware;
        const productDiscount = 0;
        let values = orderBook.map(({ variationId, salePrice, quantity }) => {
            const totalPrice = (salePrice - productDiscount) * quantity;
            return `(${orderId},${userId},${variationId},${quantity},${salePrice},${productDiscount},${totalPrice})`;
        });

        let sql = `INSERT INTO user_order_book(order_id,user_id,variation_id,quantity,product_price,product_discount,total_price) VALUES
        ${values.join(",")};`;
        db.query(sql, [],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ORDER_BOOK_FILL, err);
                }
                else {
                    next();
                }
            }
        );
    },
    //Create shipping transaction
    (req, res, next) => {
        logger.debug("Create a new shipment");
        const { addressId } = req._data.input;
        const { orderId, shipping } = req._data.middleware;
        db.query(SQL_CREATE_SHIPMENT, [orderId, addressId, shipping.amount, shipping.amount, shipping.id, shipping.shipment],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_SHIPMENT_CREATE, err);
                }
                else {
                    next();
                }
            }
        );
    },
    // Create a new transaction
    (req, res) => {
        logger.debug("Create a new transaction");
        const { orderId, totalCost } = req._data.middleware;
        db.query(SQL_CREATE_TXN, [orderId, 'ORDER', totalCost, 'PAYPAL'],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_CREATE_NEW_TXN, err);
                }
                else {
                    return res.json({
                        data: {
                            transactionId: Number(results[0][0].txn_id)
                        }
                    });
                }
            }
        );
    }
);

module.exports = router;