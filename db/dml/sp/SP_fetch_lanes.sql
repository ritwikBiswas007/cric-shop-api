/******************************************************
	NAME:           SP_fetch_lanes
 	FUNCTION:       Fetch lanes
 	MySql > CALL SP_fetch_lanes() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lanes";
DROP PROCEDURE IF EXISTS SP_fetch_lanes;

SELECT "Creating PROCEDURE SP_fetch_lanes";
DELIMITER //

CREATE PROCEDURE SP_fetch_lanes(
) 
BEGIN
	SELECT * FROM lane;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lanes created successfully";