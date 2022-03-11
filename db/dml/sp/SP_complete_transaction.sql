/******************************************************
	NAME:           SP_complete_transaction
 	FUNCTION:       Completes a transaction
 	MySql > CALL SP_complete_transaction(?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_transaction";
DROP PROCEDURE IF EXISTS SP_complete_transaction;

SELECT "Creating PROCEDURE SP_complete_transaction";
DELIMITER //

CREATE PROCEDURE SP_complete_transaction(
	IN payment_ref_id VARCHAR(512),
	IN payment_ref_token VARCHAR(512),
	IN payment_status ENUM('CONFIRMED','CANCELLED', 'FAILED'),
	IN payment_error VARCHAR(1024)
) 
BEGIN
	IF payment_ref_id IS NOT NULL THEN
		UPDATE user_transaction SET 
		user_transaction.payment_error = payment_error, 
		user_transaction.status = payment_status
		WHERE user_transaction.payment_ref_id = payment_ref_id;

		SELECT user_transaction.id, user_transaction.ref_id, user_transaction.type 
		FROM user_transaction
		WHERE user_transaction.payment_ref_id = payment_ref_id;
	ELSE
		UPDATE user_transaction SET 
		user_transaction.payment_error = payment_error, 
		user_transaction.status = payment_status
		WHERE user_transaction.payment_ref_token = payment_ref_token;

		SELECT user_transaction.id, user_transaction.ref_id, user_transaction.type 
		FROM user_transaction
		WHERE user_transaction.payment_ref_token = payment_ref_token;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_transaction created successfully";