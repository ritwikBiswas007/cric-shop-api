/******************************************************
	NAME:           SP_fetch_orders
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_orders() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_orders";
DROP PROCEDURE IF EXISTS SP_fetch_orders;

SELECT "Creating PROCEDURE SP_fetch_orders";
DELIMITER //

CREATE PROCEDURE SP_fetch_orders(
	IN user_id INTEGER
) 
BEGIN
	SELECT user_order.id, 
		user_order.status,
		user_order.created_at,
		(user_order.product_price - user_order.product_discount) AS product_price,
		(user_order.shipping_price - user_order.shipping_discount) AS shipping_cost,
		user_order.price_after_discount AS order_total,
		order_shipping.tracking_URL
	FROM user_order 
	INNER JOIN order_shipping
		ON order_shipping.order_id = user_order.id
	WHERE user_order.user_id = user_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_orders created successfully";