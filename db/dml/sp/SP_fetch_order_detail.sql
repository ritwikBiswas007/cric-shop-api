/******************************************************
	NAME:           SP_fetch_order_detail
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_order_detail() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_order_detail";
DROP PROCEDURE IF EXISTS SP_fetch_order_detail;

SELECT "Creating PROCEDURE SP_fetch_order_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_order_detail(
	IN order_id INTEGER
) 
BEGIN
	SELECT user_order.id, 
		user_order.status,
		user_order.created_at,
		products.name, products.image, 
		user_order_book.variation_id,
		user_order_book.quantity, 
		user_order_book.product_price, 
		(user_order.shipping_price - user_order.shipping_discount) AS shipping_cost,
		user_order.price_after_discount AS order_total,
		order_shipping.tracking_URL,
		user_address_book.name AS receiver_name, user_address_book.country_code,
		user_address_book.mobile_no, user_address_book.email,
		user_address_book.street1, user_address_book.city, user_address_book.state, user_address_book.country,
		user_address_book.zip_code
	FROM user_order 
	INNER JOIN user_order_book 
		ON user_order.id = user_order_book.order_id
	INNER JOIN variations
		ON user_order_book.variation_id = variations.id
	INNER JOIN products 
		ON variations.product_id = products.id 
	INNER JOIN order_shipping
		ON order_shipping.order_id = user_order.id
	INNER JOIN user_address_book
		ON user_address_book.id = order_shipping.address_id
	WHERE user_order.id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_order_detail created successfully";