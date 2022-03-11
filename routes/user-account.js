const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const validateToken = require("../lib/middleware/validateToken");
const { sendError } = require("../lib/error/error-response");

const SQL_FETCH_USER_ADDRESS = 'CALL SP_fetch_user_address(?)';

router.get('/',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user detail");
        const { userId, name, email, mobile } = req._data.middleware;
        return res.json({
            data: {
                name, email, mobile
            }
        });
    }
);

router.get('/address',
    validateToken,
    (req, res, next) => {
        logger.debug("Fetch user address list");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_USER_ADDRESS, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_USER_ADDRESS_FETCH, err);
                }
                else {
                    const address = results[0].map(address => {
                        return {
                            id: address.id,
                            name: address.name,
                            mobile: {
                                countryCode: address.country_code,
                                no: address.mobile_no
                            },
                            email: address.email,
                            street1: address.street1,
                            city: address.city,
                            state: address.state,
                            country: address.country,
                            zip: address.zip_code
                        }
                    });
                    res.json({ data: { address } });
                }
            }
        );
    }
);

module.exports = router;