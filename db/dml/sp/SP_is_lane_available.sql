/******************************************************
	NAME:           SP_is_lane_available
 	FUNCTION:       Check is lane availabe or not
 	MySql > CALL SP_is_lane_available(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_is_lane_available";
DROP PROCEDURE IF EXISTS SP_is_lane_available;

SELECT "Creating PROCEDURE SP_is_lane_available";
DELIMITER //

CREATE PROCEDURE SP_is_lane_available(
	IN lane_id INTEGER,
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	SELECT COUNT(lane_booking.id) AS is_available
	FROM lane_booking 
	WHERE
	lane_booking.lane_id = lane_id
	AND lane_booking.status IN('CONFIRMED','INITIATED','PENDING')
	AND lane_booking.started_at <= started_at
	AND lane_booking.finished_at > started_at;
END //
DELIMITER ;

SELECT "PROCEDURE SP_is_lane_available created successfully";