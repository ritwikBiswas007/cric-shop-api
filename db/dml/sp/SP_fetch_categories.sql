/******************************************************
	NAME:           SP_fetch_categories
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_categories() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_categories";
DROP PROCEDURE IF EXISTS SP_fetch_categories;

SELECT "Creating PROCEDURE SP_fetch_categories";
DELIMITER //

CREATE PROCEDURE SP_fetch_categories(
) 
BEGIN
	SELECT * FROM categories 
	WHERE parent_id = 0
	ORDER BY id ASC;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_categories created successfully";