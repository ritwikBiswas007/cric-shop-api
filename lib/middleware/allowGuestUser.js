const logger = require('../logger/winston');
const { sendError } = require("../error/error-response");
const db = require("../db/mysql");
const { jwt } = require("../jwt");
const {
    DB_ERROR_CHECK_USER_EXISTENCE,
    SIGN_IN_USER_NOT_EXISTS,
    AUTH_ERROR_INVALID_TOKEN,
    AUTH_ERROR_EXPIRED_TOKEN
} = require("../error/errors.json");

/**
 * Validates JWT token and add parsed token to the `req._token` object
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
const allowGuestUser = (req, res, next) => {
    logger.debug("Validating token");
    const bearerHeader = req.headers['authorization'];
    if (bearerHeader) {
        const bearer = bearerHeader.split(' ');
        const bearerToken = bearer[1];
        try {
            const verifiedToken = jwt.verifyToken(bearerToken);
            const values = [verifiedToken.payload.email];
            db.query('SELECT id, name, email, mobile, country_code FROM contacts WHERE contacts.email = ?', values,
                (err, results) => {
                    if (err) {
                        // TODO
                        return sendError(res, DB_ERROR_CHECK_USER_EXISTENCE, err);
                    }
                    else {
                        if (!results[0]) return sendError(res, SIGN_IN_USER_NOT_EXISTS);
                        req._data = {
                            middleware: {
                                userId: results[0].id,
                                name: results[0].name,
                                email: results[0].email,
                                mobile: { countryCode: results[0].country_code, no: results[0].mobile }
                            }
                        };
                        next();
                    }
                }
            );
        } catch (ex) {
            switch (ex.name) {
                case "TokenExpiredError":
                    return sendError(res, AUTH_ERROR_EXPIRED_TOKEN);
                default:
                    return sendError(res, AUTH_ERROR_INVALID_TOKEN, ex);
            }
        }
    } else if (req.query.session) {
        const session = req.query.session;
        req._data = {
            middleware: {
                userId: session
            }
        };
        next();
    }
    else next();
}

module.exports = allowGuestUser;