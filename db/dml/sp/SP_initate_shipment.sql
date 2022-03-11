/******************************************************
	NAME:           SP_initiate_shipment
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_initiate_shipment(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_initiate_shipment";
DROP PROCEDURE IF EXISTS SP_initiate_shipment;

SELECT "Creating PROCEDURE SP_initiate_shipment";
DELIMITER //

CREATE PROCEDURE SP_initiate_shipment(
	IN shipment_id VARCHAR(512),
	IN status ENUM('INITIATED', 'CONFIRMED', 'CANCELLED', 'FAILED'),
	IN transaction_id VARCHAR(512),
	IN shipment_rate VARCHAR(512),
	IN tracking_no VARCHAR(512),
	IN tracking_URL VARCHAR(1024),
	IN label_URL VARCHAR(1024),
	remarks VARCHAR(1024)
) 
BEGIN
	UPDATE order_shipping SET
	order_shipping.status = status,
	order_shipping.transaction_id = transaction_id,
	order_shipping.shipment_rate = shipment_rate,
	order_shipping.tracking_no = tracking_no,
	order_shipping.tracking_URL = tracking_URL,
	order_shipping.label_URL = label_URL,
	order_shipping.remarks = remarks
	WHERE order_shipping.shipment_id = shipment_id; 
END //
DELIMITER ;

SELECT "PROCEDURE SP_initiate_shipment created successfully";