USE cric_shop_api;

DROP TABLE IF EXISTS user_order_book;

CREATE TABLE user_order_book (
	id INTEGER NOT NULL AUTO_INCREMENT,
	order_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	variation_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	product_price DECIMAL(10,2) NOT NULL,
	product_discount DECIMAL(10,2) NOT NULL DEFAULT 0,
	total_price DECIMAL(10,2) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;