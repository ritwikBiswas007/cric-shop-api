/******************************************************
	NAME:           SP_fetch_category_filter
 	FUNCTION:       Fetch category filter
 	MySql > CALL SP_fetch_category_filter(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_category_filter";
DROP PROCEDURE IF EXISTS SP_fetch_category_filter;

SELECT "Creating PROCEDURE SP_fetch_category_filter";
DELIMITER //

CREATE PROCEDURE SP_fetch_category_filter(
	IN category_id INTEGER,
	IN filter_keys VARCHAR(1024)
) 
BEGIN
	SET @caterory_id = category_id;
	SET @filter_keys = filter_keys;

	SET @fetch_category_filter_query = "SELECT ? FROM variations 
	GROUP BY ?";

	PREPARE stmt FROM @fetch_category_filter_query;
	EXECUTE stmt USING @filter_keys, @filter_keys;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_category_filter created successfully";