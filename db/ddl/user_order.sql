USE cric_shop_api;

DROP TABLE IF EXISTS user_order;

CREATE TABLE user_order (
	id INTEGER NOT NULL AUTO_INCREMENT,
	user_id INTEGER NOT NULL,
	product_price DECIMAL(10,2) NOT NULL,
	product_discount DECIMAL(10,2) NOT NULL DEFAULT 0,
	shipping_price DECIMAL(10,2),
	shipping_discount DECIMAL(10,2) NOT NULL DEFAULT 0,
	price DECIMAL(10,2),
	discount DECIMAL(10,2) NOT NULL DEFAULT 0,
	price_after_discount DECIMAL(10,2),
	status ENUM(
		'INITIATED',
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	) NOT NULL DEFAULT 'INITIATED',
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;