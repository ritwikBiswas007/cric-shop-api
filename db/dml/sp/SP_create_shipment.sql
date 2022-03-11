/******************************************************
	NAME:           SP_create_shipment
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_create_shipment(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_shipment";
DROP PROCEDURE IF EXISTS SP_create_shipment;

SELECT "Creating PROCEDURE SP_create_shipment";
DELIMITER //

CREATE PROCEDURE SP_create_shipment(
	IN order_id INTEGER,
	IN address_id INTEGER,
	IN price DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN shipment_id VARCHAR(512),
	IN shipment VARCHAR(512)
) 
BEGIN
	INSERT INTO order_shipping(order_id,address_id,price,price_after_discount,shipment_id,shipment) VALUES
	(order_id,address_id,price,price_after_discount,shipment_id,shipment);
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_shipment created successfully";