/******************************************************
	NAME:           SP_update_basket
 	FUNCTION:       Update basket
 	MySql > CALL SP_update_basket(?,?,?) 
	
 	FIRST CREATED:  20211123
 	UPDATED:        20211123
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_basket";
DROP PROCEDURE IF EXISTS SP_update_basket;

SELECT "Creating PROCEDURE SP_update_basket";
DELIMITER //

CREATE PROCEDURE SP_update_basket(
	IN user_id INTEGER,
	IN variation_id INTEGER,
	IN quantity INTEGER
) 
BEGIN
	DECLARE is_available BOOLEAN;
	IF quantity = 0 THEN
		DELETE FROM user_basket 
		WHERE user_basket.user_id = user_id
		AND user_basket.variation_id = variation_id;
	ELSE 
		SELECT COUNT(user_basket.variation_id) INTO is_available 
		FROM user_basket
		WHERE user_basket.user_id = user_id
		AND user_basket.variation_id = variation_id;

		IF is_available = 0 THEN 
			INSERT INTO user_basket(user_id,variation_id,quantity) 
			VALUES(user_id,variation_id,quantity);
		ELSE 
			UPDATE user_basket 
			SET user_basket.quantity = quantity
			WHERE user_basket.user_id = user_id
			AND user_basket.variation_id = variation_id;
		END IF;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_basket created successfully";