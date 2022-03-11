const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const allowGuestSession = require("../lib/middleware/allowGuestSession");
const allowGuestUser = require("../lib/middleware/allowGuestUser");
const {
    DB_ERROR_CART_FETCH,
    DB_ERROR_CART_UPDATE
} = require("../lib/error/errors.json");

const SQL_FETCH_CART = 'CALL SP_fetch_cart(?)';
const SQL_UPDATE_CART = 'CALL SP_update_cart(?,?,?,?)';

router.get('/',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user cart detail");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_CART, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_CART_FETCH, err);
                }
                else {
                    const cart = results[0].map(item => {
                        return {
                            id: item.id,
                            name: item.name,
                            image: item.image,
                            description: item.product_description,
                            rating: item.rating,
                            fromBasket: item.from_basket,
                            variants: [
                                {
                                    id: item.variation_id,
                                    name: item.variation_name,
                                    regularPrice: {
                                        unit: "$",
                                        value: item.regular_price
                                    },
                                    salePrice: {
                                        unit: "$",
                                        value: item.sale_price
                                    },
                                    availableStock: item.qty_available,
                                    quantity: item.quantity,
                                    image: item.variant_image
                                }
                            ]
                        }
                    })
                    return res.json({ data: { cart } });
                }
            }
        );
    }
);

router.post('/:variantId/:quantity',
    validateToken,
    // create new user
    /* (req, res, next) => {
        if (req._data) return next();
        db.query('INSERT INTO contacts(business_id, type, name, password, email, country_code, mobile, created_by) VALUES(?,?,?,?,?,?,?,?); SELECT LAST INSERTED_ID;',
            [1, "customer", null, null, null, null, null, 1],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_SIGN_UP, err);
                }
                else {
                    logger.debug("Guest User created successfully");
                    next();
                }
            }
        );
    }, */
    (req, res) => {
        logger.debug("Update user cart");
        const { userId } = req._data.middleware;
        const { variantId, quantity } = req.params;
        const { fromBasket } = req.body;
        db.query(SQL_UPDATE_CART, [userId, variantId, quantity, fromBasket],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_CART_UPDATE, err);
                }
                else {
                    return res.sendStatus(200);
                }
            }
        );
    }
);



module.exports = router;