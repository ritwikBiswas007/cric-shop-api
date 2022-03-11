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
    NO_ITEMS_IN_CART_FOR_CHECKOUT,
    DB_ERROR_USER_ADDRESS_FETCH,
    DB_ERROR_CART_FETCH,
    DB_ERROR_BASKET_FETCH
} = require("../lib/error/errors.json");

const SQL_FETCH_USER_ADDRESS_DETAIL = 'CALL SP_fetch_user_address_detail(?)';
const SQL_FETCH_CART = 'CALL SP_fetch_cart(?)';
const SQL_FETCH_BASKET = 'CALL SP_fetch_basket(?)';

router.post('/:type',
    validateToken,
    (req, res, next) => {
        logger.debug("Fetch user inputs");
        let { type } = req.params;
        let { addressId, name, mobile, email, street1, city, state, zip, country } = req.body;
        req._data.input = { type, addressId, name, mobile, email, street1, city, state, zip, country };
        if (!addressId) {
            if (!name) return sendError(res, SHIPPING_NAME_MISSING);
            if (!mobile) return sendError(res, SHIPPING_MOBILE_MISSING);
            if (!street1) return sendError(res, SHIPPING_STREET_MISSING);
            if (!city) return sendError(res, SHIPPING_CITY_MISSING);
            if (!state) return sendError(res, SHIPPING_STATE_MISSING);
            if (!country) return sendError(res, SHIPPING_COUNTRY_MISSING);
            if (!zip) return sendError(res, SHIPPING_ZIP_MISSING);
        }
        // TODO add validation
        next();
    },
    (req, res, next) => {
        logger.debug("Fetch user cart detail");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_CART, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_CART_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, NO_ITEMS_IN_CART_FOR_CHECKOUT);
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
        if (addressId) return next();
        req._data.middleware = {
            ...req._data.middleware,
            addressTo: {
                name, mobile, email, street1, city, state, zip, country
            }
        };
        next();
    },
    //Prepare package from cart
    (req, res, next) => {
        logger.debug("Prepare Package");
        const { userId } = req._data.middleware;
        const { type } = req._data.input;
        if (type != 'cart') return next();
        db.query(SQL_FETCH_CART, [userId],
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
    (req, res, next) => {
        logger.debug("Prepare Package");
        const { userId } = req._data.middleware;
        const { type } = req._data.input;
        if (type != 'basket') return next();
        db.query(SQL_FETCH_BASKET, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BASKET_FETCH, err);
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
    (req, res, next) => {
        logger.debug("Send shipping cost");
        const { productCost, productDiscount, shipping } = req._data.middleware;
        const price = productCost - productDiscount + shipping.amount - 0;
        const discount = 0;
        const priceAfterDiscount = price - discount;
        res.json({
            data: {
                productCost: { unit: "$", value: productCost },
                productDiscount: { unit: "$", value: productDiscount },
                shippingCost: { unit: "$", value: shipping.amount },
                shippingDiscount: { unit: "$", value: 0 },
                totalCost: { unit: "$", value: priceAfterDiscount },
            }
        });
    }
);

module.exports = router;