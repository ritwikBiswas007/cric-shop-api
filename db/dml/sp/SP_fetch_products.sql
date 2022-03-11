/******************************************************
	NAME:           SP_fetch_products
 	FUNCTION:       Fetch products
 	MySql > CALL SP_fetch_products(?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_products";
DROP PROCEDURE IF EXISTS SP_fetch_products;

SELECT "Creating PROCEDURE SP_fetch_products";
DELIMITER //

CREATE PROCEDURE SP_fetch_products(
	IN category_ids VARCHAR(128),
	IN subcategory_ids VARCHAR(128),
	IN product_name VARCHAR(1024),
	IN brand_name VARCHAR(1024),
	IN ideal_for VARCHAR(1024),
	IN material_type VARCHAR(1024),
	IN handle_type VARCHAR(1024),
	IN style_type VARCHAR(1024),
	IN size VARCHAR(1024),
	IN color VARCHAR(1024),
	IN price_gte INTEGER,
	IN price_lte INTEGER,
	IN price_asc BOOLEAN,
	IN rating_desc BOOLEAN,
	IN newest_first BOOLEAN,
	IN page_no INTEGER,
	IN per_page INTEGER
) 
BEGIN
	SET @product_name = product_name;
	IF @product_name IS NOT NULL THEN	
		SET @product_name = CONCAT('%',@product_name,'%');
	END IF;
	SET @category_ids = category_ids;
	-- add end coma
	SET category_ids = CONCAT(category_ids,',');
	-- create temp table to store temp_category_id
	DROP TEMPORARY TABLE IF EXISTS temp_category_id;
    CREATE TEMPORARY TABLE temp_category_id(
		category_id VARCHAR(128)
	);
	-- insert into temp table temp_category_id
	SET @value = NULL;
	WHILE (LOCATE(',', category_ids) > 0)
	DO
		SET @value = SUBSTRING_INDEX(category_ids, ',', 1);
		SET category_ids = SUBSTRING(category_ids, LOCATE(',',category_ids) + 1);
        INSERT INTO temp_category_id VALUES(@value);
	END WHILE;
	
	SET @subcategory_ids = subcategory_ids;
	-- add end coma
	SET subcategory_ids = CONCAT(subcategory_ids,',');
	-- create temp table to store temp_subcategory_id
	DROP TEMPORARY TABLE IF EXISTS temp_subcategory_id;
    CREATE TEMPORARY TABLE temp_subcategory_id(
		subcategory_id VARCHAR(128)
	);
	-- insert into temp table temp_subcategory_id
	SET @value = NULL;
	WHILE (LOCATE(',', subcategory_idS) > 0)
	DO
		SET @value = SUBSTRING_INDEX(subcategory_ids, ',', 1);
		SET subcategory_ids = SUBSTRING(subcategory_ids, LOCATE(',',subcategory_ids) + 1);
        INSERT INTO temp_subcategory_id VALUES(@value);
	END WHILE;
	
	SET @brand_name = brand_name;
	-- add end coma
	SET brand_name = CONCAT(brand_name,',');
	-- create temp table to store temp_brand_name
	DROP TEMPORARY TABLE IF EXISTS temp_brand_name;
    CREATE TEMPORARY TABLE temp_brand_name(
		brand_name VARCHAR(128)
	);
	-- insert into temp table temp_brand_name
	SET @value = NULL;
	WHILE (LOCATE(',', brand_name) > 0)
	DO
		SET @value = SUBSTRING_INDEX(brand_name, ',', 1);
		SET brand_name = SUBSTRING(brand_name, LOCATE(',',brand_name) + 1);
        INSERT INTO temp_brand_name VALUES(@value);
	END WHILE;

	SET @ideal_for = ideal_for;
	-- add end coma
	SET ideal_for = CONCAT(ideal_for,',');
	-- create temp table to store temp_ideal_for
	DROP TEMPORARY TABLE IF EXISTS temp_ideal_for;
    CREATE TEMPORARY TABLE temp_ideal_for(
		ideal_for VARCHAR(128)
	);
	-- insert into temp table temp_ideal_for
	SET @value = NULL;
	WHILE (LOCATE(',', brand_name) > 0)
	DO
		SET @value = SUBSTRING_INDEX(ideal_for, ',', 1);
		SET ideal_for = SUBSTRING(brand_name, LOCATE(',',ideal_for) + 1);
        INSERT INTO temp_ideal_for VALUES(@value);
	END WHILE;

	SET @material_type = material_type;
	-- add end coma
	SET material_type = CONCAT(material_type,',');
	-- create temp table to store temp_material_type
	DROP TEMPORARY TABLE IF EXISTS temp_material_type;
    CREATE TEMPORARY TABLE temp_material_type(
		material_type VARCHAR(128)
	);
	-- insert into temp table temp_material_type
	SET @value = NULL;
	WHILE (LOCATE(',', brand_name) > 0)
	DO
		SET @value = SUBSTRING_INDEX(material_type, ',', 1);
		SET material_type = SUBSTRING(material_type, LOCATE(',',material_type) + 1);
        INSERT INTO temp_material_type VALUES(@value);
	END WHILE;

	SET @handle_type = handle_type;
	-- add end coma
	SET handle_type = CONCAT(handle_type,',');
	-- create temp table to store temp_handle_type
	DROP TEMPORARY TABLE IF EXISTS temp_handle_type;
    CREATE TEMPORARY TABLE temp_handle_type(
		handle_type VARCHAR(128)
	);
	-- insert into temp table temp_handle_type
	SET @value = NULL;
	WHILE (LOCATE(',', handle_type) > 0)
	DO
		SET @value = SUBSTRING_INDEX(handle_type, ',', 1);
		SET handle_type = SUBSTRING(handle_type, LOCATE(',',handle_type) + 1);
        INSERT INTO temp_handle_type VALUES(@value);
	END WHILE;

	SET @style_type = style_type;
	-- add end coma
	SET style_type = CONCAT(style_type,',');
	-- create temp table to store temp_style_type
	DROP TEMPORARY TABLE IF EXISTS temp_style_type;
    CREATE TEMPORARY TABLE temp_style_type(
		style_type VARCHAR(128)
	);
	-- insert into temp table temp_style_type
	SET @value = NULL;
	WHILE (LOCATE(',', style_type) > 0)
	DO
		SET @value = SUBSTRING_INDEX(style_type, ',', 1);
		SET style_type = SUBSTRING(style_type, LOCATE(',',style_type) + 1);
        INSERT INTO temp_style_type VALUES(@value);
	END WHILE;

	SET @size = size;
	-- add end coma
	SET size = CONCAT(size,',');
	-- create temp table to store temp_size
	DROP TEMPORARY TABLE IF EXISTS temp_size;
    CREATE TEMPORARY TABLE temp_size(
		size VARCHAR(128)
	);
	-- insert into temp table temp_size
	SET @value = NULL;
	WHILE (LOCATE(',', size) > 0)
	DO
		SET @value = SUBSTRING_INDEX(size, ',', 1);
		SET size = SUBSTRING(size, LOCATE(',',size) + 1);
        INSERT INTO temp_size VALUES(@value);
	END WHILE;
	
	SET @color = color;
	-- add end coma
	SET color = CONCAT(color,',');
	-- create temp table to store temp_color
	DROP TEMPORARY TABLE IF EXISTS temp_color;
    CREATE TEMPORARY TABLE temp_color(
		color VARCHAR(128)
	);
	-- insert into temp table temp_color
	SET @value = NULL;
	WHILE (LOCATE(',', color) > 0)
	DO
		SET @value = SUBSTRING_INDEX(color, ',', 1);
		SET color = SUBSTRING(color, LOCATE(',',color) + 1);
        INSERT INTO temp_color VALUES(@value);
	END WHILE;
	
	SET @price_gte = price_gte;
	SET @price_lte = price_lte;
	SET @price_order = "variations.sell_price_inc_tax ASC";
	SET @rating_order = "product.rating DESC";
	SET @creation_order = "variations.created_at DESC";
	SET @offset = 0;
	SET @limit = 1000;

	IF price_asc IS FALSE THEN 
		SET @price_order = "variations.sell_price_inc_tax DESC";
	END IF;
	IF rating_desc IS FALSE THEN 
		SET @rating_order = "product.rating ASC";
	END IF;
	IF newest_first IS FALSE THEN 
		SET @creation_order = "variations.created_at ASC";
	END IF;
	IF page_no IS NOT NULL AND page_no > 0 THEN 
		SET @limit = page_no;
	END IF;
	IF page_no IS NOT NULL AND page_no > 0 THEN 
		SET @offset = page_no * @limit;
	END IF;

	SET @fetch_products_query = "SELECT products.id, products.name, products.image,
		variations.id AS variation_id, variations.name AS variation_name,
        variations.sell_price_inc_tax AS regular_price,
        MIN(variations.sell_price_inc_tax) AS sale_price,
		variation_location_details.qty_available
	FROM variations
	INNER JOIN products 
		ON variations.product_id = products.id 
	INNER JOIN brands
		ON products.brand_id = brands.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE 
		( ? IS NULL OR products.sub_category_id IN (SELECT subcategory_id FROM temp_subcategory_id) ) AND 
		( ? IS NULL OR products.category_id IN (SELECT category_id FROM temp_category_id) ) AND 
		( ? IS NULL OR products.name LIKE ?) AND
		( ? IS NULL OR brands.name IN (SELECT brand_name FROM temp_brand_name)) AND
		( ? IS NULL OR products.product_filter_custom_field1 IN (SELECT ideal_for FROM temp_ideal_for)) AND
		( ? IS NULL OR products.product_filter_custom_field2 IN (SELECT material_type FROM temp_material_type)) AND
		( ? IS NULL OR products.product_filter_custom_field3 IN (SELECT handle_type FROM temp_handle_type)) AND
		( ? IS NULL OR products.product_filter_custom_field4 IN (SELECT style_type FROM temp_style_type)) AND
		( ? IS NULL OR TRIM(SUBSTRING(variations.name,1,LOCATE(? ,variations.name)-1)) IN (SELECT size FROM temp_size)) AND 
		( ? IS NULL OR TRIM(SUBSTRING(variations.name,LOCATE(? ,variations.name)+1)) IN (SELECT color FROM temp_color)) AND		
		( ? IS NULL OR variations.sell_price_inc_tax >= ? ) AND		
		( ? IS NULL OR variations.sell_price_inc_tax <= ? )		
	GROUP BY products.id 
	ORDER BY 
		?, ?
	LIMIT ?, ?";
	SET @coma = ',';
	PREPARE stmt FROM @fetch_products_query;
	EXECUTE stmt USING @subcategory_ids, @category_ids, 
	@product_name, @product_name,
	@brand_name,
	@ideal_for,
	@material_type,
	@handle_type,
	@style_type,
	@size, @coma,
	@color, @coma,
	@price_gte, @price_gte,
	@price_lte, @price_lte,
	@price_order, @creation_order, @offset, @limit;
	DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_products created successfully";