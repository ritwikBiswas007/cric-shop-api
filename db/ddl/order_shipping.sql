USE cric_shop_api;

DROP TABLE IF EXISTS order_shipping;

CREATE TABLE order_shipping (
	id INTEGER NOT NULL AUTO_INCREMENT,
	order_id INTEGER NOT NULL,
	address_id INTEGER NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	price_after_discount DECIMAL(10,2) NOT NULL,
	status ENUM(
		'CREATED',
		'INITIATED',
		'CONFIRMED',
		'CANCELLED',
		'FAILED'
	) NOT NULL DEFAULT 'CREATED',
	shipment_id VARCHAR(512) NOT NULL,
	shipment VARCHAR(512) NOT NULL,
	transaction_id VARCHAR(512),
	shipment_rate VARCHAR(512),
	tracking_no VARCHAR(512),
	tracking_URL VARCHAR(1024),
	label_URL VARCHAR(2048),
	remarks VARCHAR(2048),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;