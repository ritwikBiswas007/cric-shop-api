/******************************************************
	NAME:           SP_fetch_sub_category_detail
 	FUNCTION:       Fetch sub-category detail
 	MySql > CALL SP_fetch_sub_category_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_sub_category_detail";
DROP PROCEDURE IF EXISTS SP_fetch_sub_category_detail;

SELECT "Creating PROCEDURE SP_fetch_sub_category_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_sub_category_detail(
	IN sub_category_id INTEGER
) 
BEGIN
	SELECT * FROM categories 
	WHERE id = sub_category_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_sub_category_detail created successfully";