/******************************************************
	NAME:           SP_create_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_booking(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_booking";
DROP PROCEDURE IF EXISTS SP_create_booking;

SELECT "Creating PROCEDURE SP_create_booking";
DELIMITER //

CREATE PROCEDURE SP_create_booking(
	IN lane_id INTEGER,
	IN user_id INTEGER,
	IN team_name VARCHAR(128),
	IN no_of_member INTEGER,
	IN price DECIMAL(10,2),
	IN tax DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	INSERT INTO lane_booking(lane_id,user_id,team_name,no_of_member,price,tax,price_after_discount,started_at,finished_at) VALUES
	(lane_id,user_id,team_name,no_of_member,price,tax,price_after_discount,started_at,finished_at);
	SELECT LAST_INSERT_ID() AS booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_booking created successfully";