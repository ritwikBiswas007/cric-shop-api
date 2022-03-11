/******************************************************
	NAME:           SP_complete_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_complete_booking(?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_booking";
DROP PROCEDURE IF EXISTS SP_complete_booking;

SELECT "Creating PROCEDURE SP_complete_booking";
DELIMITER //

CREATE PROCEDURE SP_complete_booking(
	IN booking_id INTEGER,
	IN status ENUM(
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	)
) 
BEGIN
	UPDATE lane_booking SET lane_booking.status = status
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_booking created successfully";