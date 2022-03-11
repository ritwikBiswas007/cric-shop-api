/******************************************************
	NAME:           SP_fetch_category_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_category_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_category_detail";
DROP PROCEDURE IF EXISTS SP_fetch_category_detail;

SELECT "Creating PROCEDURE SP_fetch_category_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_category_detail(
	IN category_id INTEGER
) 
BEGIN
	SELECT categories.id, categories.name, categories.image, categories.parent_id,
	T.id AS sub_category_id, T.name AS sub_category_name
	FROM categories LEFT JOIN categories T 
		ON categories.id = T.parent_id
	WHERE categories.id = category_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_category_detail created successfully";