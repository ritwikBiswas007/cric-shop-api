const logger = require('../logger/winston');
/**
 * @param {import('express').Response} res Response object
 * @param {error.ErrorDefinition} error
 * @param {any} [data]
 * @param {object} [response] If provided, error is merged with this to
 * create the response.
 */
function sendError(res, error, data, response) {
    logger.error(error, data);
    return res.status(error.status).json({
        ...response,
        error: {
            code: error.code,
            message: error.message,
            data,
        }
    });
}

exports.sendError = sendError;