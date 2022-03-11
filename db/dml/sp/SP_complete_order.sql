/******************************************************
	NAME:           SP_complete_order
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_complete_order(?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_order";
DROP PROCEDURE IF EXISTS SP_complete_order;

SELECT "Creating PROCEDURE SP_complete_order";
DELIMITER //

CREATE PROCEDURE SP_complete_order(
	IN order_id INTEGER,
	IN status ENUM(
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	)
) 
BEGIN
	UPDATE user_order SET user_order.status = status
	WHERE user_order.id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_order created successfully";