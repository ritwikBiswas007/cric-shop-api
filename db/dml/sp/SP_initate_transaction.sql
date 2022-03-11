/******************************************************
	NAME:           SP_initiate_transaction
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_initiate_transaction(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_initiate_transaction";
DROP PROCEDURE IF EXISTS SP_initiate_transaction;

SELECT "Creating PROCEDURE SP_initiate_transaction";
DELIMITER //

CREATE PROCEDURE SP_initiate_transaction(
	IN txn_id INTEGER,
	IN payment_ref_id VARCHAR(512),
	IN payment_ref_token VARCHAR(512)
) 
BEGIN
	UPDATE user_transaction SET 
	user_transaction.payment_ref_id = payment_ref_id,
	user_transaction.payment_ref_token = payment_ref_token,
	user_transaction.status = 'INITIATED'
	WHERE user_transaction.id = txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_initiate_transaction created successfully";