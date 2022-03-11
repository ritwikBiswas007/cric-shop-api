/******************************************************
	NAME:           SP_fetch_booking_cost
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_booking_cost(?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_booking_cost";
DROP PROCEDURE IF EXISTS SP_fetch_booking_cost;

SELECT "Creating PROCEDURE SP_fetch_booking_cost";
DELIMITER //

CREATE PROCEDURE SP_fetch_booking_cost(
	IN laneId INTEGER,
	IN dayOfWeek INTEGER,
	IN noOfPerson INTEGER
) 
BEGIN
	SELECT * FROM lane_pricing
	WHERE lane_pricing.lane_id = laneId AND
	lane_pricing.day_of_week = dayOfWeek AND
	lane_pricing.no_of_person <= noOfPerson
	ORDER BY lane_pricing.no_of_person DESC;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_booking_cost created successfully";