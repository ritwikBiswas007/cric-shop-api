/******************************************************
	NAME:           SP_fetch_user_address_detail
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_user_address_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_user_address_detail";
DROP PROCEDURE IF EXISTS SP_fetch_user_address_detail;

SELECT "Creating PROCEDURE SP_fetch_user_address_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_user_address_detail(
	IN address_id INTEGER
) 
BEGIN
	SELECT * FROM user_address_book WHERE id = address_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_user_address_detail created successfully";