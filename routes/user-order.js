const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const {
    DB_ERROR_USER_ORDERS_FETCH,
    DB_ERROR_USER_ORDER_DETAIL_FETCH,
} = require("../lib/error/errors.json");

const SQL_FETCH_ORDERS = 'CALL SP_fetch_orders(?)';
const SQL_FETCH_ORDER_DETAIL = 'CALL SP_fetch_order_detail(?)';

router.get('/',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user orders");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_ORDERS, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ORDERS_FETCH, err);
                }
                else {
                    const orders = results[0].map(({ id, status, created_at, product_price, shipping_cost, order_total, tracking_URL }) => {
                        return {
                            id,
                            status,
                            orderDate: created_at,
                            price: product_price,
                            totalCost: order_total,
                            shippingCost: shipping_cost,
                            trackingURL: tracking_URL
                        };
                    });
                    return res.json({
                        data: {
                            orders: orders
                        }
                    });
                }
            }
        );
    }
);

router.get('/:orderId',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user order detail");
        const { orderId } = req.params;
        db.query(SQL_FETCH_ORDER_DETAIL, [orderId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ORDER_DETAIL_FETCH, err);
                }
                else {
                    const { created_at, status, receiver_name, country_code, mobile_no, email, street1,
                        city, state, country, zip_code, shipping_cost, order_total, tracking_URL } = results[0][0];
                    const address = {
                        name: receiver_name,
                        mobile: {
                            countryCode: country_code,
                            no: mobile_no
                        },
                        email, street1, city, state, country, zip_code
                    };
                    const items = results[0].map(({ name, variation_id, image, quantity, product_price, }) => {
                        return { variationId: variation_id, name, image, quantity, price: product_price };
                    });
                    return res.json({
                        data: {
                            order: {
                                orderDate: created_at,
                                status,
                                address,
                                trackingURL: tracking_URL,
                                shippingCost: { unit: "$", value: shipping_cost },
                                totalCost: { unit: "$", value: order_total },
                                items
                            }
                        }
                    });
                }
            }
        );
    }
);

module.exports = router;