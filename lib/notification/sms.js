const config = require('config');
const logger = require('../logger/winston');
const sid = config.get('NOTIFICATION.SMS.TWILIO.sid');
const authToken = config.get('NOTIFICATION.SMS.TWILIO.authToken');
const from = config.get('NOTIFICATION.SMS.TWILIO.from');
const twilioClient = require('twilio')(sid, authToken);

/**
 * @param {import('express').Request} req Request object
 * @param {import('express').Response} res Response object
 * @param {import('express').NextFunction} next Next middleware
 */
function sendSMS(req, res, next) {
    logger.debug("Sending sms");
    /**
     * @type {notification.SMS}
     */
    const smsContent = req._data.middleware.smsContent;
    twilioClient.messages.create({ ...smsContent, from }, (err, item) => {
        if (err) {
            logger.error(`Failed to send sms ${smsContent.body} to ${smsContent.to}`);
            logger.error(err);
            next();
        }
        else {
            logger.error(item);
            next();
        }
    });
}

module.exports = { sendSMS };