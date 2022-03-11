/******************************************************
	NAME:           SP_fetch_cart
 	FUNCTION:       Fetch cart
 	MySql > CALL SP_fetch_cart(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_cart";
DROP PROCEDURE IF EXISTS SP_fetch_cart;

SELECT "Creating PROCEDURE SP_fetch_cart";
DELIMITER //

CREATE PROCEDURE SP_fetch_cart(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_cart_query = "SELECT 
		products.id, products.name, products.image, 
		products.weight, 
		products.product_custom_field1 AS length, 
		products.product_custom_field2 AS width, 
		products.product_custom_field3 AS depth, 
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available,
		user_cart.quantity,
		user_cart.from_basket
	FROM user_cart 
	INNER JOIN variations 
		ON user_cart.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_cart.user_id = ?
	ORDER BY user_cart.created_at DESC";

	PREPARE stmt FROM @fetch_cart_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_cart created successfully";