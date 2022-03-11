/******************************************************
	NAME:           SP_fetch_basket
 	FUNCTION:       Fetch basket
 	MySql > CALL SP_fetch_basket(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_basket";
DROP PROCEDURE IF EXISTS SP_fetch_basket;

SELECT "Creating PROCEDURE SP_fetch_basket";
DELIMITER //

CREATE PROCEDURE SP_fetch_basket(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_basket_query = "SELECT 
		products.id, products.name, products.image, 
		products.weight, 
		products.product_custom_field1 AS length, 
		products.product_custom_field2 AS width, 
		products.product_custom_field3 AS depth,
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available,
		user_basket.quantity
	FROM user_basket 
	INNER JOIN variations 
		ON user_basket.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_basket.user_id = ?
	ORDER BY user_basket.created_at DESC";

	PREPARE stmt FROM @fetch_basket_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_basket created successfully";