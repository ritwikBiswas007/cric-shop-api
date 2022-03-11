/******************************************************
	NAME:           SP_create_user_order
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_user_order(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_user_order";
DROP PROCEDURE IF EXISTS SP_create_user_order;

SELECT "Creating PROCEDURE SP_create_user_order";
DELIMITER //

CREATE PROCEDURE SP_create_user_order(
	IN user_id INTEGER,
	IN product_price DECIMAL(10,2),
	IN product_discount DECIMAL(10,2),
	IN shipping_price DECIMAL(10,2),
	IN shipping_discount DECIMAL(10,2),
	IN price DECIMAL(10,2),
	IN dicount DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2)
) 
BEGIN
	INSERT INTO user_order(user_id,product_price,product_discount,shipping_price,shipping_discount,price,dicount,price_after_discount) VALUES
	(user_id,product_price,product_discount,shipping_price,shipping_discount,price,dicount,price_after_discount);
	SELECT LAST_INSERT_ID() AS order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_user_order created successfully";