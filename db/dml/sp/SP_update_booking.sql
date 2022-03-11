/******************************************************
	NAME:           SP_update_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_update_booking(?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_booking";
DROP PROCEDURE IF EXISTS SP_update_booking;

SELECT "Creating PROCEDURE SP_update_booking";
DELIMITER //

CREATE PROCEDURE SP_update_booking(
	IN booking_id INTEGER,
	IN no_of_member INTEGER,
	IN price DECIMAL(10,2),
	IN tax DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	UPDATE lane_booking SET
	lane_booking.no_of_member = no_of_member,
	lane_booking.started_at = started_at,
	lane_booking.finished_at = finished_at,
	lane_booking.price = price,
	lane_booking.tax = tax,
	lane_booking.price_after_discount = price_after_discount,
	lane_booking.status = 'UPDATED'
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_booking created successfully";