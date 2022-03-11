/******************************************************
	NAME:           SP_update_cart
 	FUNCTION:       Update cart
 	MySql > CALL SP_update_cart(?,?,?,?) 
	
 	FIRST CREATED:  20211123
 	UPDATED:        20211123
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_cart";
DROP PROCEDURE IF EXISTS SP_update_cart;

SELECT "Creating PROCEDURE SP_update_cart";
DELIMITER //

CREATE PROCEDURE SP_update_cart(
	IN user_id INTEGER,
	IN variation_id INTEGER,
	IN quantity INTEGER,
	IN from_basket BOOLEAN
) 
BEGIN
	DECLARE is_available BOOLEAN;
	IF quantity = 0 THEN
		DELETE FROM user_cart 
		WHERE user_cart.user_id = user_id
		AND user_cart.variation_id = variation_id;
	ELSE 
		SELECT COUNT(user_cart.variation_id) INTO is_available 
		FROM user_cart
		WHERE user_cart.user_id = user_id
		AND user_cart.variation_id = variation_id;

		IF is_available = 0 THEN 
			INSERT INTO user_cart(user_id,variation_id,quantity,from_basket) 
			VALUES(user_id,variation_id,quantity,from_basket);
		ELSE 
			UPDATE user_cart 
			SET user_cart.quantity = quantity
			WHERE user_cart.user_id = user_id
			AND user_cart.variation_id = variation_id
			AND user_cart.from_basket = from_basket;
		END IF;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_cart created successfully";