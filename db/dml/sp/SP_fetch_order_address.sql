/******************************************************
	NAME:           SP_fetch_order_address
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_order_address(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_order_address";
DROP PROCEDURE IF EXISTS SP_fetch_order_address;

SELECT "Creating PROCEDURE SP_fetch_order_address";
DELIMITER //

CREATE PROCEDURE SP_fetch_order_address(
	IN track_no VARCHAR(512)
) 
BEGIN
	SELECT user_address_book.country_code, user_address_book.mobile_no, user_address_book.email FROM order_shipping 
	INNER JOIN user_address_book 
		ON order_shipping.address_id = user_address_book.id
	WHERE order_shipping.tracking_no = track_no;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_order_address created successfully";