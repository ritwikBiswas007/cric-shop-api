const config = require('config');
const logger = require('../logger/winston');
const sgMail = require('@sendgrid/mail')
const sendGridEmailKey = config.get('NOTIFICATION.EMAIL.SEND_GRID.key');
const from = config.get('NOTIFICATION.EMAIL.SEND_GRID.from');
sgMail.setApiKey(sendGridEmailKey);

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function sendMail(req, res, next) {
    logger.debug("Sending email");
    /**
     * @type {notification.Email}
     */
    const emailContent = req._data.middleware.emailContent;
    sgMail.send({ ...emailContent, from }, (err, result) => {
        if (err) {
            logger.error(`Failed to send email ${emailContent.subject} to ${emailContent.to}`);
            logger.error(err);
            next();
        }
        else {
            next();
        }
    });
}

module.exports = { sendMail };
