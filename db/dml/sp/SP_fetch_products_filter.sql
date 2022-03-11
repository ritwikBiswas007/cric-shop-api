/******************************************************
	NAME:           SP_fetch_products_filter
 	FUNCTION:       Fetch products
 	MySql > CALL SP_fetch_products_filter(?,?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_products_filter";
DROP PROCEDURE IF EXISTS SP_fetch_products_filter;

SELECT "Creating PROCEDURE SP_fetch_products_filter";
DELIMITER //

CREATE PROCEDURE SP_fetch_products_filter(
	IN cat_id VARCHAR(128),
	IN sub_cat_id VARCHAR(128)
) 
BEGIN
	-- filter size
	SELECT brands.name AS brand, 
	CASE
		WHEN variations.variation_value_id IS NULL THEN NULL
		ELSE SUBSTRING(variations.name,1,POSITION("," IN variations.name)-1)
	END AS size,
	CASE
		WHEN variations.variation_value_id IS NULL THEN NULL
		ELSE SUBSTRING(variations.name,POSITION("," IN variations.name)+1)
	END AS color, 
	products.product_filter_custom_field1 AS ideal_for, 
	products.product_filter_custom_field2 AS material_type, 
	products.product_filter_custom_field3 AS handle_type, 
	products.product_filter_custom_field4 AS style_type, 
	MAX(variations.sell_price_inc_tax) AS price 
	FROM products INNER JOIN variations 
		ON products.id = variations.product_id
	INNER JOIN brands 
		ON brands.id = products.brand_id
	WHERE (cat_id IS NOT NULL AND products.category_id = cat_id) OR 
	(sub_cat_id IS NOT NULL AND products.sub_category_id = sub_cat_id)
	GROUP BY brands.name, 
	SUBSTRING(variations.name,1,POSITION("," IN variations.name)-1), 
	SUBSTRING(variations.name,POSITION("," IN variations.name)+1), 
	products.product_filter_custom_field1, products.product_filter_custom_field2, products.product_filter_custom_field3, products.product_filter_custom_field4;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_products_filter created successfully";