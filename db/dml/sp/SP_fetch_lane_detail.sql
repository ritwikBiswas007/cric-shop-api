/******************************************************
	NAME:           SP_fetch_lane_detail
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_lane_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lane_detail";
DROP PROCEDURE IF EXISTS SP_fetch_lane_detail;

SELECT "Creating PROCEDURE SP_fetch_lane_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_lane_detail(
	IN lane_id INTEGER
) 
BEGIN
	SELECT * from lane WHERE lane.id = lane_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lane_detail created successfully";