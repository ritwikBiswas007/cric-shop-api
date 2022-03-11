/******************************************************
	NAME:           SP_fetch_product_detail
 	FUNCTION:       Fetch product detail
 	MySql > CALL SP_fetch_product_detail(?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_product_detail";
DROP PROCEDURE IF EXISTS SP_fetch_product_detail;

SELECT "Creating PROCEDURE SP_fetch_product_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_product_detail(
	IN product_id INTEGER
) 
BEGIN
	SET @product_id = product_id;
	SET @fetch_product_detail_query = "SELECT 
		products.id, products.name, products.product_description, products.long_description, products.additional_information,
		products.image, products.product_images AS gallery, 
		products.weight, 
		products.product_custom_field1 AS length, products.product_custom_field2 AS height, products.product_custom_field3 AS width,
		products.product_filter_custom_field1 AS ideal_for, 
		products.product_filter_custom_field2 AS material_type, 
		products.product_filter_custom_field3 AS handle_type, 
		products.product_filter_custom_field4 AS style_type, 
		units.id AS unit_id, units.actual_name AS unit_name,
		brands.id AS brand_id, brands.name AS brand_name,
		categories.id AS category_id, categories.name AS category_name,
		variations.id AS variation_id, variations.name AS variation_name,
		TRIM(SUBSTRING(variations.name,1,LOCATE(? ,variations.name)-1)) AS size,
		TRIM(SUBSTRING(variations.name,LOCATE(? ,variations.name)+1)) AS color,
		variations.sell_price_inc_tax AS regular_price, variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available
	FROM products 
	LEFT JOIN business_locations 
		ON products.business_id = business_locations.id
	LEFT JOIN units
		ON products.unit_id = units.id
	LEFT JOIN brands 
		ON products.brand_id = brands.id
	LEFT JOIN categories 
		ON products.category_id = categories.id
	LEFT JOIN variations
		ON products.id = variations.product_id
	INNER JOIN variation_location_details
		ON variations.id = variation_location_details.variation_id
	WHERE products.id = ?";

	PREPARE stmt FROM @fetch_product_detail_query;
	EXECUTE stmt USING ",",",",@product_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_product_detail created successfully";