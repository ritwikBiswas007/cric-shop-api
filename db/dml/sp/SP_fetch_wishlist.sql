/******************************************************
	NAME:           SP_fetch_wishlist
 	FUNCTION:       Fetch wishlist
 	MySql > CALL SP_fetch_wishlist(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_wishlist";
DROP PROCEDURE IF EXISTS SP_fetch_wishlist;

SELECT "Creating PROCEDURE SP_fetch_wishlist";
DELIMITER //

CREATE PROCEDURE SP_fetch_wishlist(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_wishlist_query = "SELECT 
		products.id, products.name, products.image, 
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available
	FROM user_wishlist 
	INNER JOIN variations 
		ON user_wishlist.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_wishlist.user_id = ?
	ORDER BY user_wishlist.created_at DESC";

	PREPARE stmt FROM @fetch_wishlist_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_wishlist created successfully";