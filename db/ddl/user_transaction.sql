USE cric_shop_api;

DROP TABLE IF EXISTS user_transaction;

CREATE TABLE user_transaction (
	id INTEGER NOT NULL AUTO_INCREMENT,
	ref_id INTEGER NOT NULL,
	type ENUM('BOOKING', 'ORDER') NOT NULL,
	total DECIMAL(10,2) NOT NULL,
	method ENUM('PAYPAL', 'STRIPE', 'CASH') NOT NULL,
	status ENUM(
		'CREATED',
		'INITIATED',
		'CONFIRMED',
		'CANCELLED',
		'FAILED'
	) NOT NULL DEFAULT 'CREATED',
	is_credit BOOLEAN NOT NULL DEFAULT TRUE,
	is_web BOOLEAN NOT NULL DEFAULT TRUE,
	payment_ref_id VARCHAR(512),
	payment_ref_token VARCHAR(512),
	payment_error VARCHAR(1024),
	remarks VARCHAR(512),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;