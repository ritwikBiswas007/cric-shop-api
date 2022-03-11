const express = require('express');
const router = express.Router();
const logger = require('../lib/logger/winston');
const db = require("../lib/db/mysql");
const { sendError } = require("../lib/error/error-response");
const validateToken = require("../lib/middleware/validateToken");
const {
    DB_ERROR_BOOKINGS_FETCH,
    DB_ERROR_BOOKING_DETAIL_FETCH,
} = require("../lib/error/errors.json");

const SQL_FETCH_BOOKINGS = 'CALL SP_fetch_bookings(?)';
const SQL_FETCH_BOOKING_DETAIL = 'CALL SP_fetch_booking_detail(?)';

router.get('/',
    validateToken,
    (req, res) => {
        logger.debug("Fetch user bookings");
        const { userId } = req._data.middleware;
        db.query(SQL_FETCH_BOOKINGS, [userId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BOOKINGS_FETCH, err);
                }
                else {
                    const bookings = results[0].map(({ id, lane_id, created_at, status, name, image, team_name, started_at, finished_at, no_of_member, price_after_discount }) => {
                        return { bookingId: id, laneId: lane_id, status, bookingDate: created_at, name, image, teamName: team_name, member: no_of_member, from: started_at, to: finished_at, member: no_of_member, price: price_after_discount };
                    });
                    return res.json({
                        data: {
                            bookings: bookings
                        }
                    });
                }
            }
        );
    }
);

router.get('/:bookingId',
    //validateToken,
    (req, res) => {
        logger.debug("Fetch user booking detail");
        const { bookingId } = req.params;
        db.query(SQL_FETCH_BOOKING_DETAIL, [bookingId],
            (err, results) => {
                if (err) {
                    // TODO
                    return sendError(res, DB_ERROR_BOOKING_DETAIL_FETCH, err);
                }
                else {
                    const bookings = results[0].map(({ id, lane_id, created_at, status, name, image, team_name, started_at, finished_at, no_of_member, price_after_discount }) => {
                        return { bookingId: id, laneId: lane_id, bookingDate: created_at, status, name, image, teamName: team_name, member: no_of_member, from: started_at, to: finished_at, price: price_after_discount };
                    });
                    return res.json({
                        data: {
                            booking: bookings[0] || {}
                        }
                    });
                }
            }
        );
    }
);

module.exports = router;