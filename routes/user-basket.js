const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const {
    DB_ERROR_BASKET_FETCH,
    DB_ERROR_BASKET_UPDATE,
} = require("../lib/error/errors.json");

const SQL_FETCH_BASKET = 'CALL SP_fetch_basket(?)';
const SQL_UPDATE_BASKET = 'CALL SP_update_basket(?,?,?)';

router.get('/',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user basket detail");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_BASKET, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BASKET_FETCH, err);
                }
                else {
                    const basket = results[0].map(item => {
                        return {
                            id: item.id,
							name: item.name,
							image: item.image,
							description: item.product_description,
							rating: item.rating,
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
									image: item.variant_image
								}
							]
                        }
                    })
                    return res.json({ data: { basket } });
                }
            }
        );
    }
);

router.post('/:variantId/:quantity',
    validateToken,
    (req, res) => {
        logger.debug("Update user basket");
        const { userId } = req._data.middleware;
        const { variantId, quantity } = req.params;
        db.query(SQL_UPDATE_BASKET, [userId, variantId, quantity],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BASKET_UPDATE, err);
                }
                else {
                    return res.sendStatus(200);
                }
            }
        );
    }
);

module.exports = router;