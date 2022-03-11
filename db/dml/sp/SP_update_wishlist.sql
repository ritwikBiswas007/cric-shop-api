/******************************************************
	NAME:           SP_update_wishlist
 	FUNCTION:       Update wishlist
 	MySql > CALL SP_update_wishlist(?,?,?) 
	
 	FIRST CREATED:  20211123
 	UPDATED:        20211123
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_wishlist";
DROP PROCEDURE IF EXISTS SP_update_wishlist;

SELECT "Creating PROCEDURE SP_update_wishlist";
DELIMITER //

CREATE PROCEDURE SP_update_wishlist(
	IN user_id INTEGER,
	IN variation_id INTEGER,
	IN quantity INTEGER
) 
BEGIN
	DECLARE is_available BOOLEAN;
	IF quantity = 0 THEN
		DELETE FROM user_wishlist 
		WHERE user_wishlist.user_id = user_id
		AND user_wishlist.variation_id = variation_id;
	ELSE 
		SELECT COUNT(user_wishlist.variation_id) INTO is_available 
		FROM user_wishlist
		WHERE user_wishlist.user_id = user_id
		AND user_wishlist.variation_id = variation_id;

		IF is_available = 0 THEN 
			INSERT INTO user_wishlist(user_id,variation_id,quantity) 
			VALUES(user_id,variation_id,quantity);
		ELSE 
			UPDATE user_wishlist 
			SET user_wishlist.quantity = quantity
			WHERE user_wishlist.user_id = user_id
			AND user_wishlist.variation_id = variation_id;
		END IF;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_wishlist created successfully";