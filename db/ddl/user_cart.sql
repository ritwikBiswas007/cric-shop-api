USE cric_shop_api;

DROP TABLE IF EXISTS user_cart;

CREATE TABLE user_cart (
	user_id INTEGER NOT NULL,
	variation_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;