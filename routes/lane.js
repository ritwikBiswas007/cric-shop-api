const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
var moment = require('moment-timezone');


const {
    DB_ERROR_LANES_FETCH,
    DB_ERROR_LANE_BOOKINGS_FETCH,
    DB_ERROR_LANE_AVAILABILITY_FETCH,
    LANE_BOOKING_ALREADY_BOOKED,
    DB_ERROR_LANE_DETAIL_FETCH,
    LANE_INVALID_ID,
    CHECK_LANE_AVAILABILITY_MISSING_FROM,
    CHECK_LANE_AVAILABILITY_MISSING_TO,
    CHECK_LANE_AVAILABILITY_MISSING_MEMBER,
    CHECK_LANE_AVAILABILITY_INVALID_FROM,
    CHECK_LANE_AVAILABILITY_INVALID_TO,
    CHECK_LANE_AVAILABILITY_INVALID_MEMBER
} = require("../lib/error/errors.json");

const SQL_FETCH_LANES = "CALL SP_fetch_lanes()";
const SQL_FETCH_LANE_DETAIL = "CALL SP_fetch_lane_detail(?)";
const SQL_FETCH_LANE_BOOKINGS = "CALL SP_fetch_lane_bookings(?)";
const SQL_FETCH_LANE_AVAILABILITY = "CALL SP_is_lane_available(?,?,?)";
const SQL_FETCH_BOOKING_COST = 'CALL SP_fetch_booking_cost(?,?,?)';

/**
 * Fetch list of all lanes
 */
router.get('/',
    (req, res) => {
        logger.debug("Fetch lane list");
        db.query(SQL_FETCH_LANES, [],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANES_FETCH, err);
                }
                else {
                    const lanes = results[0].map(({ id, name, image, rate }) => {
                        return {
                            id, name, image,
                            rate: {
                                unit: "$",
                                value: Number(rate)
                            }
                        };
                    });
                    return res.json({ data: { lanes: lanes } });
                }
            }
        );
    }
);

/**
 * Fetch a lane detail
 */
router.get('/:laneId',
    (req, res, next) => {
        logger.debug("Fetch lane detail");
        const { laneId } = req.params;
        db.query(SQL_FETCH_LANE_DETAIL, [laneId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const { id, name, image, gallery, short_description, long_description, rate } = results[0][0];
                    const lane = {
                        id, name, image,
                        gallery: gallery ? gallery.split(",") : [],
                        description: long_description,
                        shortDescription: short_description,
                        rate: {
                            unit: "$",
                            value: Number(rate)
                        },
                    };
                    req._data = { middleware: { lane } };
                    next();
                }
            }
        );
    },
    (req, res, next) => {
        logger.debug("Fetch lane bookings for next 1 months");
        let { lane } = req._data.middleware;
        db.query(SQL_FETCH_LANE_BOOKINGS, [lane.id],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_BOOKINGS_FETCH, err);
                }
                else {
                    const bookings = results[0].map(({ started_at, finished_at }) => {
                        return {
                            start: started_at,
                            end: finished_at
                        };
                    });
                    lane.bookings = bookings;
                    return res.json({
                        data: {
                            lane
                        }
                    });
                }
            }
        );
    }
);

/**
 * Fetch a lane availability
 */
router.get('/:laneId/availability',
    validateToken,
    (req, res, next) => {
        logger.debug("Fetch lane booking cost");
        const { laneId } = req.params;
        let { from, to, member } = req.query;
        if (!from) return sendError(res, CHECK_LANE_AVAILABILITY_MISSING_FROM);
        if (!to) return sendError(res, CHECK_LANE_AVAILABILITY_MISSING_TO);
        if (!member) return sendError(res, CHECK_LANE_AVAILABILITY_MISSING_MEMBER);
        from = Number(from);
        to = Number(to);
        member = Number(member);
        const now = Date.now();
        const twoMonthAdvance = now + 2 * 30 * 24 * 3600 * 1000;
        if (from > to) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_FROM);
        if (from <= now || from > twoMonthAdvance) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_FROM);
        if (to <= now || to > twoMonthAdvance) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_TO);
        //if (from % 3600000 !== 0) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_FROM);
        //if (to % 3600000 !== 0) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_TO);
        if ((to - from) / 3600000 > 2) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_TO);
        if (from <= 0) return sendError(res, CHECK_LANE_AVAILABILITY_INVALID_MEMBER);
        req._data.input = { laneId, from, to, member };
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
                    if (results[0][0].is_available == 0) next();
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
                            }
                        }
                    });
                }
            });
    }
    /* (req, res) => {
        logger.debug("Fetch lane detail");
        const { laneId, from, to, member } = req._data.input;
        db.query(SQL_FETCH_LANE_DETAIL, [laneId],
            (err, results) => {
                if (err) {
                    return sendError(res, DB_ERROR_LANE_DETAIL_FETCH, err);
                }
                else {
                    if (!results[0].length) return sendError(res, LANE_INVALID_ID);
                    const rate  = Number(results[0][0].rate);
                    const bookingCost = member * rate * (to - from) / 3600000;
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
                            }
                        }
                    });
                }
            }
        );
    }, */
);


module.exports = router;