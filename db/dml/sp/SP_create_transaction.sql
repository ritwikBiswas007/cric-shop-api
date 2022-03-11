/******************************************************
	NAME:           SP_create_transaction
 	FUNCTION:       Create a new transaction
 	MySql > CALL SP_create_transaction(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_transaction";
DROP PROCEDURE IF EXISTS SP_create_transaction;

SELECT "Creating PROCEDURE SP_create_transaction";
DELIMITER //

CREATE PROCEDURE SP_create_transaction(
	IN ref_id INTEGER,
	IN type ENUM('BOOKING', 'ORDER'),
	IN total DECIMAL,
	IN method ENUM('PAYPAL', 'STRIPE')
) 
BEGIN
	INSERT INTO user_transaction(ref_id,type,total,method) VALUES
	(ref_id,type,total,method);
	SELECT LAST_INSERT_ID() AS txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_transaction created successfully";