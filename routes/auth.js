const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const bcrypt = require('bcrypt');
const { jwt } = require("../lib/jwt");
const { sendError } = require("../lib/error/error-response");
const { sendMail } = require("../lib/notification/email");
const { sendSMS } = require("../lib/notification/sms");
const { generateOTP } = require("../lib/util");
const notificationTemplate = require("../lib/notification/template");
const {
	SIGN_UP_MISSING_NAME,
	SIGN_UP_MISSING_EMAIL,
	SIGN_UP_MISSING_MOBILE,
	SIGN_UP_MISSING_PASSWORD,
	SIGN_UP_INVALID_EMAIL,
	SIGN_UP_INVALID_MOBILE,
	SIGN_UP_INVALID_PASSWORD,
	DB_ERROR_CHECK_DUPLICATE_USER_EMAIL,
	DB_ERROR_CHECK_DUPLICATE_USER_MOBILE,
	DB_ERROR_USER_SIGN_UP,
	SIGN_IN_MISSING_PASSWORD,
	SIGN_IN_MISSING_EMAIL,
	DB_ERROR_CHECK_USER_EXISTENCE,
	SIGN_IN_USER_NOT_EXISTS,
	SIGN_IN_ERROR_PASSWORD_VALIDATION_FAILED,
	SIGN_IN_ERROR_PASSWORD_MISMATCH,
	SIGN_IN_ERROR_TOKEN_CREATION
} = require("../lib/error/errors.json");

const {
	SIGN_UP_DUPLICATE_EMAIL,
	SIGN_UP_DUPLICATE_MOBILE
} = require("../lib/error/errors.json");

/**
 * New user sign up
 */
router.post('/signup',
	// input validation middleware
	(req, res, next) => {
		logger.debug("Request for user signup");
		const { name, email, password, mobile } = req.body;
		// validate missing inputs
		if (!name) return sendError(res, SIGN_UP_MISSING_NAME);
		if (!email) return sendError(res, SIGN_UP_MISSING_EMAIL);
		if (!mobile) return sendError(res, SIGN_UP_MISSING_MOBILE);
		if (!password) return sendError(res, SIGN_UP_MISSING_PASSWORD);
		// validate inputs
		if (!mobile.countryCode || !mobile.no) return sendError(res, SIGN_UP_INVALID_MOBILE);
		// TODO validate email
		// TODO validate password
		req._data = { input: { name, email, password, mobile } };
		next();
	},
	// validate existing user existence with email
	(req, res, next) => {
		const { email } = req._data.input;
		db.query('SELECT COUNT(contacts.id) AS count FROM contacts WHERE contacts.email = ?', [email],
			(err, results) => {
				if (err) {
					// TODO
					return sendError(res, DB_ERROR_CHECK_DUPLICATE_USER_EMAIL, err);
				}
				else {
					if (results[0].count > 0) return sendError(res, SIGN_UP_DUPLICATE_EMAIL);
					else next();
				}
			}
		);
	},
	// validate existing user existence with mobile
	(req, res, next) => {
		const { mobile } = req._data.input;
		db.query('SELECT COUNT(contacts.id) AS count FROM contacts WHERE contacts.mobile = ?', [mobile.no],
			(err, results) => {
				if (err) {
					// TODO
					return sendError(res, DB_ERROR_CHECK_DUPLICATE_USER_MOBILE, err);
				}
				else {
					if (results[0].count > 0) return sendError(res, SIGN_UP_DUPLICATE_MOBILE);
					else next();
				}
			}
		);
	},
	// encrypt password
	(req, res, next) => {
		const { password } = req._data.input;
		bcrypt.hash(password, 10, (err, hashedPassword) => {
			if (err) return sendError(res, SIGN_UP_ERROR_ENCRYPTING_PASSWORD, err);
			else {
				req._data.middleware = { hashedPassword };
				next();
			}
		});
	},
	// create new user
	(req, res, next) => {
		const { name, email, mobile } = req._data.input;
		const { hashedPassword } = req._data.middleware;
		db.query('INSERT INTO contacts(business_id, type, name, password, email, country_code, mobile, created_by) VALUES(?,?,?,?,?,?,?,?)',
			[1, "customer", name, hashedPassword, email, mobile.countryCode, mobile.no, 1],
			(err, results) => {
				if (err) {
					// TODO
					return sendError(res, DB_ERROR_USER_SIGN_UP, err);
				}
				else {
					logger.debug("User created successfully");
					next();
				}
			}
		);
	},
	// Prepare email content
	(req, res, next) => {
		const { email, mobile } = req._data.input;
		req._data.middleware = {
			...req._data.middleware,
			emailContent: {
				to: email,
				subject: notificationTemplate['USER_REGISTRATION'].MAIL.subject,
				html: notificationTemplate['USER_REGISTRATION'].MAIL.html
			},
			smsContent: {
				to: `${mobile.countryCode}${mobile.no}`,
				body: notificationTemplate['USER_REGISTRATION'].SMS.body
			},
		};
		next();
	},
	sendMail,
	//sendSMS,
	(req, res, next) => {
		res.sendStatus(200);
	}
);

/**
 * User login
 */
router.post('/login',
	//input sanity check
	(req, res, next) => {
		const { email, password, mobile } = req.body;
		// validate inputs
		if (!password)
			return sendError(res, SIGN_IN_MISSING_PASSWORD);
		if (!email && !mobile)
			return sendError(res, SIGN_IN_MISSING_EMAIL);

		req._data = { input: { email, password, mobile } };
		next();
	},
	// validate user from DB
	(req, res, next) => {
		const { email, mobile } = req._data.input;
		const values = email ? [email] : [mobile.countryCode, mobile.no];
		const SQL = email ? 'SELECT email, mobile, country_code, password FROM contacts WHERE contacts.email = ?' :
			'SELECT email, mobile, country_code, password FROM contacts WHERE contacts.country_code = ? AND contacts.mobile = ?';
		// validate existing user existence with key
		db.query(SQL, values,
			(err, results) => {
				if (err) {
					// TODO
					return sendError(res, DB_ERROR_CHECK_USER_EXISTENCE, err);
				}
				else {
					if (!results[0]) return sendError(res, SIGN_IN_USER_NOT_EXISTS);
					else {
						req._data.middleware = {
							email: results[0].email,
							mobile: { countryCode: results[0].country_code, no: results[0].mobile },
							hashedPassword: results[0].password
						};
						next();
					}
				}
			}
		);
	},
	// match password
	(req, res, next) => {
		const { password } = req._data.input;
		const { hashedPassword } = req._data.middleware;
		bcrypt.compare(password, hashedPassword, (err, same) => {
			if (err) return sendError(res, SIGN_IN_ERROR_PASSWORD_VALIDATION_FAILED, err);
			else if (!same) return sendError(res, SIGN_IN_ERROR_PASSWORD_MISMATCH);
			next();
		});
	},
	// generate token and pass
	(req, res, next) => {
		const { email, mobile } = req._data.middleware;
		let token;
		try {
			token = jwt.createToken({ email, mobile });
		} catch (ex) {
			return sendError(res, SIGN_IN_ERROR_TOKEN_CREATION, ex);
		}
		return res.json({ data: { token, isGuest: false } });
	}
);

/**
 * User login
 */
router.post('/forget-password',
	//input sanity check
	(req, res, next) => {
		const { email, password, mobile } = req.body;
		// validate inputs
		if (!password)
			return sendError(res, SIGN_IN_MISSING_PASSWORD);
		if (!email && !mobile)
			return sendError(res, SIGN_IN_MISSING_EMAIL);

		req._data = { input: { email, password, mobile } };
		next();
	},
	// validate user from DB
	(req, res, next) => {
		const { email, mobile } = req._data.input;
		const values = email ? [email] : [mobile.countryCode, mobile.no];
		const SQL = email ? 'SELECT email, mobile, country_code, password FROM contacts WHERE contacts.email = ?' :
			'SELECT email, mobile, country_code, password FROM contacts WHERE contacts.country_code = ? AND contacts.mobile = ?';
		// validate existing user existence with key
		db.query(SQL, values,
			(err, results) => {
				if (err) {
					// TODO
					return sendError(res, DB_ERROR_CHECK_USER_EXISTENCE, err);
				}
				else {
					if (!results[0]) return sendError(res, SIGN_IN_USER_NOT_EXISTS);
					else {
						req._data.middleware = {
							email: results[0].email,
							mobile: { countryCode: results[0].country_code, no: results[0].mobile },
							hashedPassword: results[0].password
						};
						next();
					}
				}
			}
		);
	},
	// match password
	(req, res, next) => {
		const { password } = req._data.input;
		const { hashedPassword } = req._data.middleware;
		bcrypt.compare(password, hashedPassword, (err, same) => {
			if (err) return sendError(res, SIGN_IN_ERROR_PASSWORD_VALIDATION_FAILED, err);
			else if (same) return sendError(res, RESET_PASSWORD_IS_SAME);
			next();
		});
	},
	// generate mail and sms content 
	(req, res, next) => {
		const { email, mobile } = req._data.middleware;
		let otp = generateOTP();
		req._data.middleware = {
			...req._data.middleware,
			emailContent: {
				to: email,
				subject: notificationTemplate['PASSWORD_RESET'].MAIL.subject,
				html: notificationTemplate['PASSWORD_RESET'].MAIL.html.replace('$', otp)
			},
			smsContent: {
				to: `${mobile.countryCode}${mobile.no}`,
				body: notificationTemplate['PASSWORD_RESET'].SMS.body.replace('$', otp),
			},
		};
		next();
	},
	//sendSMS,
	sendMail
);

module.exports = router;
