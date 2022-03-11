/******************************************************
	NAME:           SP_fetch_user_address
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_user_address(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_user_address";
DROP PROCEDURE IF EXISTS SP_fetch_user_address;

SELECT "Creating PROCEDURE SP_fetch_user_address";
DELIMITER //

CREATE PROCEDURE SP_fetch_user_address(
	IN u_id INTEGER
) 
BEGIN
	SELECT * FROM user_address_book WHERE user_address_book.user_id = u_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_user_address created successfully";