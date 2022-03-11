/******************************************************
	NAME:           SP_fetch_transaction_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_transaction_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_transaction_detail";
DROP PROCEDURE IF EXISTS SP_fetch_transaction_detail;

SELECT "Creating PROCEDURE SP_fetch_transaction_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_transaction_detail(
	IN txn_id INTEGER
) 
BEGIN
	SELECT * FROM user_transaction WHERE user_transaction.id = txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_transaction_detail created successfully";