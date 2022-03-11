const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
var moment = require('moment-timezone');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
var moment = require('moment-timezone');


const {
    DB_ERROR_LANE_AVAILABILITY_FETCH,
    LANE_BOOKING_ALREADY_BOOKED,
    DB_ERROR_LANE_DETAIL_FETCH,
    DB_ERROR_NEW_LANE_BOOKING,
    DB_ERROR_UPDATE_LANE_BOOKING,
    DB_ERROR_CREATE_NEW_TXN,
    LANE_INVALID_ID,
    LANE_BOOKING_MISSING_LANE_ID,
    LANE_BOOKING_MISSING_FROM,
    LANE_BOOKING_MISSING_TO,
    LANE_BOOKING_MISSING_MEMBER,
    LANE_BOOKING_MISSING_TEAM_NAME,
    LANE_BOOKING_INVALID_FROM,
    LANE_BOOKING_INVALID_TO,
    LANE_BOOKING_INVALID_MEMBER,
    DB_ERROR_BOOKING_DETAIL_FETCH
} = require("../lib/error/errors.json");

const SQL_FETCH_LANE_DETAIL = "CALL SP_fetch_lane_detail(?)";
const SQL_FETCH_LANE_AVAILABILITY = "CALL SP_is_lane_available(?,?,?)";
const SQL_CREATE_LANE_BOOKING = "CALL SP_create_booking(?,?,?,?,?,?,?,?,?)";
const SQL_UPDATE_LANE_BOOKING = "CALL SP_update_booking(?,?,?,?,?,?,?)";
const SQL_CREATE_TXN = "CALL SP_create_transaction(?,?,?,?)";
const SQL_FETCH_BOOKING_DETAIL = 'CALL SP_fetch_booking_detail(?)';
const SQL_FETCH_BOOKING_COST = 'CALL SP_fetch_booking_cost(?,?,?)';

/**
 * Book a lane
 */
router.post('/',
    validateToken,
    (req, res, next) => {
        logger.debug("validate inputs");
        const { laneId, from, to, member, teamName, method } = req.body;
        if (!laneId) return sendError(res, LANE_BOOKING_MISSING_LANE_ID);
        if (!from) return sendError(res, LANE_BOOKING_MISSING_FROM);
        if (!to) return sendError(res, LANE_BOOKING_MISSING_TO);
        if (!member) return sendError(res, LANE_BOOKING_MISSING_MEMBER);
        if (!teamName) return sendError(res, LANE_BOOKING_MISSING_TEAM_NAME);
        const now = Date.now();
        const twoMonthAdvance = now + 2 * 30 * 24 * 3600 * 1000;
        if (from > to) return sendError(res, LANE_BOOKING_INVALID_FROM);
        if (from <= now || from > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_FROM);
        if (to <= now || to > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_TO);
        if ((to - from) / 1800000 > 4) return sendError(res, LANE_BOOKING_INVALID_TO);
        if (from <= 0) return sendError(res, LANE_BOOKING_INVALID_MEMBER);
        req._data.input = { laneId, teamName, from, to, member };
        next();
    },
    (req, res, next) => {
        const { laneId, from, to, member } = req._data.input;
        const hour = Number(moment(1640870793046).tz("America/Los_Angeles").format().substr(11, 2));
        db.query(SQL_FETCH_BOOKING_COST, [laneId, 1, member],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rates = results[0].map(({ duration_in_minute, after_hour, before_hour, no_of_person, price }) => {
                        return {
                            minute: duration_in_minute,
                            after: after_hour,
                            before: before_hour,
                            noOfPerson: no_of_person,
                            price: price,
                        }
                    })[0];
                    if (!rates) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(rates.price);
                    const bookingCost = Math.ceil(member * rate * (to - from) * 1.9375 / 1800000);
                    req._data.middleware = {
                        ...req._data.middleware,
                        bookingCost: {
                            unit: "$",
                            value: bookingCost
                        },
                        bookingDiscount: {
                            unit: "$",
                            value: 0
                        },
                        totalCost: {
                            unit: "$",
                            value: bookingCost
                        }
                    };
                    next();
                }
            }
        );
    },
    /* (req, res, next) => {
        logger.debug("Fetch lane detail");
        const { laneId, from, to, member } = req._data.input;
        db.query(SQL_FETCH_LANE_DETAIL, [laneId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(results[0][0].rate);
                    const bookingCost = member * rate * (to - from) / 1800000;
                    req._data.middleware = {
                        ...req._data.middleware,
                        bookingCost: {
                            unit: "$",
                            value: bookingCost
                        },
                        bookingDiscount: {
                            unit: "$",
                            value: 0
                        },
                        totalCost: {
                            unit: "$",
                            value: bookingCost
                        }
                    };
                    next();
                }
            }
        );
    }, */
    // Match with input
    (req, res, next) => {
        next();
    },
    (req, res, next) => {
        logger.debug("Check lane availability");
        const { laneId, from, to } = req._data.input;
        db.query(SQL_FETCH_LANE_AVAILABILITY, [laneId, from, to],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_AVAILABILITY_FETCH, err);
                }
                else {
                    if (results[0][0].is_available == 0) {
                        next();
                    }
                    else {
                        return sendError(res, LANE_BOOKING_ALREADY_BOOKED);
                    }
                }
            }
        );
    },
    // Create a booking
    (req, res, next) => {
        logger.debug("Book a lane");
        const { laneId, teamName, from, to, member, } = req._data.input;
        const { userId, bookingCost, bookingDiscount, totalCost } = req._data.middleware;
        db.query(SQL_CREATE_LANE_BOOKING, [laneId, userId, teamName, member, bookingCost.value, 0, totalCost.value, from, to],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_NEW_LANE_BOOKING, err);
                }
                else {
                    req._data.middleware = { ...req._data.middleware, bookingId: results[0][0].booking_id };
                    next();
                }
            }
        );
    },
    // Create a new transaction
    (req, res) => {
        logger.debug("Create a new transaction");
        const { bookingId, totalCost } = req._data.middleware;
        db.query(SQL_CREATE_TXN, [bookingId, 'BOOKING', totalCost.value, 'PAYPAL'],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_CREATE_NEW_TXN, err);
                }
                else {
                    return res.json({
                        data: {
                            transactionId: Number(results[0][0].txn_id)
                        }
                    });
                }
            }
        );
    }
);

/**
 * Book a lane update booking
 */
router.patch('/:bookingId',
    validateToken,
    (req, res, next) => {
        logger.debug("Validates inputs");
        const { bookingId } = req.params;
        const { from, to, member, method } = req.body;
        if (!from && !to && !member) return sendError(res, LANE_BOOKING_MISSING_MEMBER);
        if (from && !to) return sendError(res, LANE_BOOKING_MISSING_TO);
        if (to && !from) return sendError(res, LANE_BOOKING_MISSING_FROM);
        if (from && to) {
            const now = Date.now();
            const twoMonthAdvance = now + 2 * 30 * 24 * 3600 * 1000;
            if (from > to) return sendError(res, LANE_BOOKING_INVALID_FROM);
            if (from <= now || from > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_FROM);
            if (to <= now || to > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_TO);
            if ((to - from) / 1800000 > 4) return sendError(res, LANE_BOOKING_INVALID_TO);
            if (member <= 0) return sendError(res, LANE_BOOKING_INVALID_MEMBER);
        }
        req._data.input = { bookingId, from, to, member };
        logger.debug(JSON.stringify(req._data.input));
        next();
    },
    (req, res, next) => {
        logger.debug("Fetch user booking detail");
        const { bookingId } = req._data.input;
        db.query(SQL_FETCH_BOOKING_DETAIL, [bookingId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BOOKING_DETAIL_FETCH, err);
                }
                else {
                    req._data.middleware = {
                        oldCost: {
                            unit: "$",
                            value: results[0][0].price_after_discount
                        }
                    };
                    req._data.input.laneId = results[0][0].lane_id;
                    req._data.input.member = req._data.input.member ? req._data.input.member : results[0][0].no_of_member;
                    req._data.input.from = req._data.input.from ? req._data.input.from : results[0][0].started_at;
                    req._data.input.to = req._data.input.to ? req._data.input.to : results[0][0].finished_at;
                    logger.debug(JSON.stringify(req._data.input));
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Check lane availability");
        const { laneId, from, to } = req._data.input;
        if (!req.body.from || !req.body.to) return next();
        db.query(SQL_FETCH_LANE_AVAILABILITY, [laneId, from, to],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_AVAILABILITY_FETCH, err);
                }
                else {
                    if (results[0][0].is_available == 0) {
                        next();
                    }
                    else {
                        return sendError(res, LANE_BOOKING_ALREADY_BOOKED);
                    }
                }
            }
        );
    },
    (req, res, next) => {
        const { laneId, from, to, member } = req._data.input;
        const hour = Number(moment(1640870793046).tz("America/Los_Angeles").format().substr(11, 2));
        db.query(SQL_FETCH_BOOKING_COST, [laneId, 1, member],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rates = results[0].map(({ duration_in_minute, after_hour, before_hour, no_of_person, price }) => {
                        return {
                            minute: duration_in_minute,
                            after: after_hour,
                            before: before_hour,
                            noOfPerson: no_of_person,
                            price: price,
                        }
                    })[0];
                    if (!rates) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(rates.price);
                    const bookingCost = Math.ceil(member * rate * (to - from) * 1.9375 / 1800000);
                    req._data.middleware = {
                        ...req._data.middleware,
                        bookingCost: {
                            unit: "$",
                            value: bookingCost
                        },
                        bookingDiscount: {
                            unit: "$",
                            value: 0
                        },
                        totalCost: {
                            unit: "$",
                            value: bookingCost
                        }
                    };
                    next();
                }
            }
        );
    },
    /* (req, res, next) => {
        logger.debug("Fetch lane detail");
        const { laneId, from, to, member } = req._data.input;
        db.query(SQL_FETCH_LANE_DETAIL, [laneId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(results[0][0].rate);
                    const bookingCost = member * rate * (to - from) / 1800000;
                    req._data.middleware = {
                        ...req._data.middleware,
                        bookingCost: {
                            unit: "$",
                            value: bookingCost
                        },
                        bookingDiscount: {
                            unit: "$",
                            value: 0
                        },
                        totalCost: {
                            unit: "$",
                            value: bookingCost
                        }
                    };
                    next();
                }
            }
        );
    }, */
    // Match with input
    (req, res, next) => {
        next();
    },
    // Update a booking
    (req, res, next) => {
        logger.debug("Update a lane booking");
        const { bookingId, from, to, member, } = req._data.input;
        const { bookingCost, bookingDiscount, totalCost } = req._data.middleware;
        db.query(SQL_UPDATE_LANE_BOOKING, [bookingId, member, bookingCost.value, 0, totalCost.value, from, to],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_UPDATE_LANE_BOOKING, err);
                }
                else {
                    next();
                }
            }
        );
    },
    // Create a new transaction
    (req, res) => {
        logger.debug("Create a new transaction");
        const { bookingId } = req._data.input;
        const { totalCost, oldCost } = req._data.middleware;
        db.query(SQL_CREATE_TXN, [bookingId, 'BOOKING', totalCost.value - oldCost.value, 'PAYPAL'],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_CREATE_NEW_TXN, err);
                }
                else {
                    return res.json({
                        data: {
                            transactionId: Number(results[0][0].txn_id)
                        }
                    });
                }
            }
        );
    }
);

/**
 * Book a lane
 */
router.post('/:bookingId',
    validateToken,
    (req, res, next) => {
        logger.debug("Validates inputs");
        const { bookingId } = req.params;
        const { from, to, member } = req.body;
        if (!from && !to && !member) return sendError(res, LANE_BOOKING_MISSING_MEMBER);
        if (from && !to) return sendError(res, LANE_BOOKING_MISSING_TO);
        if (to && !from) return sendError(res, LANE_BOOKING_MISSING_FROM);
        if (from && to) {
            const now = Date.now();
            const twoMonthAdvance = now + 2 * 30 * 24 * 3600 * 1000;
            if (from > to) return sendError(res, LANE_BOOKING_INVALID_FROM);
            if (from <= now || from > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_FROM);
            if (to <= now || to > twoMonthAdvance) return sendError(res, LANE_BOOKING_INVALID_TO);
            if ((to - from) / 1800000 > 4) return sendError(res, LANE_BOOKING_INVALID_TO);
            if (member <= 0) return sendError(res, LANE_BOOKING_INVALID_MEMBER);
        }
        req._data.input = { bookingId, from, to, member };
        next();
    },
    (req, res, next) => {
        logger.debug("Fetch user booking detail");
        const { bookingId } = req._data.input;
        db.query(SQL_FETCH_BOOKING_DETAIL, [bookingId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BOOKING_DETAIL_FETCH, err);
                }
                else {
                    req._data.middleware = {
                        totalCost: {
                            unit: "$",
                            value: results[0][0].price_after_discount
                        }
                    };
                    req._data.input.laneId = results[0][0].lane_id;
                    req._data.input.member = req._data.input.member ? req._data.input.member : results[0][0].no_of_member;
                    req._data.input.from = req._data.input.from ? req._data.input.from : results[0][0].started_at;
                    req._data.input.to = req._data.input.to ? req._data.input.to : results[0][0].finished_at;
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Check lane availability");
        const { laneId, from, to } = req._data.input;
        if (!req.body.from || !req.body.to) return next();
        db.query(SQL_FETCH_LANE_AVAILABILITY, [laneId, from, to],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_AVAILABILITY_FETCH, err);
                }
                else {
                    if (results[0][0].is_available == 0) {
                        next();
                    }
                    else {
                        return sendError(res, LANE_BOOKING_ALREADY_BOOKED);
                    }
                }
            }
        );
    },
    (req, res, next) => {
        const { laneId, from, to, member } = req._data.input;
        const hour = Number(moment(1640870793046).tz("America/Los_Angeles").format().substr(11, 2));
        const { totalCost } = req._data.middleware;
        db.query(SQL_FETCH_BOOKING_COST, [laneId, 1, member],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rates = results[0].map(({ duration_in_minute, after_hour, before_hour, no_of_person, price }) => {
                        return {
                            minute: duration_in_minute,
                            after: after_hour,
                            before: before_hour,
                            noOfPerson: no_of_person,
                            price: price,
                        }
                    })[0];
                    if (!rates) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(rates.price);
                    const bookingCost = Math.ceil(member * rate * (to - from) * 1.9375 / 1800000) - totalCost.value;
                    return res.json({
                        data: {
                            bookingCost: {
                                unit: "$",
                                value: bookingCost
                            },
                            bookingDiscount: {
                                unit: "$",
                                value: 0
                            },
                            totalCost: {
                                unit: "$",
                                value: bookingCost
                            },
                            oldCost: {
                                totalCost
                            }
                        }
                    });
                }
            });
    }
    /* (req, res) => {
        logger.debug("Fetch lane detail");
        const { laneId, from, to, member } = req._data.input;
        const { totalCost } = req._data.middleware;
        db.query(SQL_FETCH_LANE_DETAIL, [laneId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rate = Number(results[0][0].rate);
                    const bookingCost = member * rate * (to - from) / 1800000 - totalCost.value;
                    res.json({
                        data: {
                            bookingCost: {
                                unit: "$",
                                value: bookingCost
                            },
                            bookingDiscount: {
                                unit: "$",
                                value: 0
                            },
                            totalCost: {
                                unit: "$",
                                value: bookingCost
                            },
                            oldCost: {
                                totalCost
                            }
                        }
                    });
                }
            }
        );
    } */
);

module.exports = router;