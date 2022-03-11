/******************************************************
	NAME:           SP_fetch_lane_bookings
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_lane_bookings(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lane_bookings";
DROP PROCEDURE IF EXISTS SP_fetch_lane_bookings;

SELECT "Creating PROCEDURE SP_fetch_lane_bookings";
DELIMITER //

CREATE PROCEDURE SP_fetch_lane_bookings(
	IN lane_id INTEGER
) 
BEGIN
	SELECT lane_booking.started_at, lane_booking.finished_at
	FROM lane_booking
	WHERE
	lane_booking.lane_id = lane_id
	AND lane_booking.status IN ('CONFIRMED','INITIATED','PENDING','UPDATED')
	AND lane_booking.started_at >= UNIX_TIMESTAMP()*1000;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lane_bookings created successfully";