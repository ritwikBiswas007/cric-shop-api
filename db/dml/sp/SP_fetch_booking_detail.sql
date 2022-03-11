/******************************************************
	NAME:           SP_fetch_booking_detail
 	FUNCTION:       Fetch cart
 	MySql > CALL SP_fetch_booking_detail(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_booking_detail";
DROP PROCEDURE IF EXISTS SP_fetch_booking_detail;

SELECT "Creating PROCEDURE SP_fetch_booking_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_booking_detail(
	IN booking_id INTEGER
) 
BEGIN
	SELECT lane_booking.id, lane_booking.created_at, lane_booking.status, lane.name, lane.image, 
	lane_booking.team_name, lane_booking.no_of_member, 
	lane_booking.price, lane_booking.price_after_discount,
	lane_booking.started_at, lane_booking.finished_at,
	lane_booking.lane_id
	FROM lane_booking INNER JOIN lane
		ON	lane.id = lane_booking.lane_id
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_booking_detail created successfully";