/******************************************************
	NAME:           SP_create_user_address
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_user_address(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_user_address";
DROP PROCEDURE IF EXISTS SP_create_user_address;

SELECT "Creating PROCEDURE SP_create_user_address";
DELIMITER //

CREATE PROCEDURE SP_create_user_address(
	IN user_id INTEGER,
	IN name VARCHAR(128),
	IN country_code VARCHAR(8),
	IN mobile_no VARCHAR(10),
	IN email VARCHAR(512),
	IN street1 VARCHAR(512),
	IN street2 VARCHAR(512),
	IN city VARCHAR(128),
	IN state VARCHAR(128),
	IN country VARCHAR(128),
	IN zip_code VARCHAR(128)
) 
BEGIN
	INSERT INTO user_address_book(user_id,name,country_code,mobile_no,email,street1,street2,city,state,country,zip_code) VALUES
	(user_id,name,country_code,mobile_no,email,street1,street2,city,state,country,zip_code);
	SELECT LAST_INSERT_ID() AS address_id; 
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_user_address created successfully";