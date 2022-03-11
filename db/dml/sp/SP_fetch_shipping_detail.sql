/******************************************************
	NAME:           SP_fetch_shipping_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_shipping_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_shipping_detail";
DROP PROCEDURE IF EXISTS SP_fetch_shipping_detail;

SELECT "Creating PROCEDURE SP_fetch_shipping_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_shipping_detail(
	IN order_id INTEGER
) 
BEGIN
	SELECT * FROM order_shipping WHERE order_shipping.order_id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_shipping_detail created successfully";