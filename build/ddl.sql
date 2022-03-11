USE cric_shop_api;

DROP TABLE IF EXISTS category_filter;

CREATE TABLE category_filter (
	category_id INTEGER NOT NULL,
	filter_key VARCHAR(128) NOT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO category_filter VALUES
(1, "BRAND"),
(1, "IDEAL FOR"),
(1, "HANDLE"),
(1, "MATERIAL"),
(1, "COLOR"),
(2, "BRAND"),
(2, "IDEAL FOR"),
(2, "MATERIAL"),
(2, "COLOR");
USE cric_shop_api;

DROP TABLE IF EXISTS lane;

CREATE TABLE lane (
	id INTEGER NOT NULL AUTO_INCREMENT,
	name VARCHAR(128) NOT NULL,
	image VARCHAR(512) NULL,
	gallery TEXT NULL,
	short_description VARCHAR(1024) NULL,
	long_description VARCHAR(1024) NULL,
	rate DECIMAL NOT NULL DEFAULT 0.0,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS lane_booking;

CREATE TABLE lane_booking (
	id INTEGER NOT NULL AUTO_INCREMENT,
	user_id INTEGER NOT NULL,
	lane_id INTEGER NOT NULL,
	team_name VARCHAR(128) NOT NULL,
	no_of_member INTEGER NOT NULL,
	price DECIMAL NOT NULL,
	price_after_discount DECIMAL NOT NULL,
	status ENUM(
		'INITIATED',
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	) NOT NULL DEFAULT 'INITIATED',
	started_at BIGINT NOT NULL,
	finished_at BIGINT NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS order_shipping;

CREATE TABLE order_shipping (
	id INTEGER NOT NULL AUTO_INCREMENT,
	order_id INTEGER NOT NULL,
	address_id INTEGER NOT NULL,
	price DECIMAL NOT NULL,
	price_after_discount DECIMAL NOT NULL,
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
	trackingNumber VARCHAR(512),
	trackingURL VARCHAR(1024),
	labelURL VARCHAR(2048),
	remarks VARCHAR(2048),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS payment_detail;

CREATE TABLE payment_detail (
	id INTEGER NOT NULL AUTO_INCREMENT,
	transaction_id INTEGER NOT NULL,
	amount INTEGER,
	payer_id VARCHAR(64),
	token VARCHAR(64),
	payment_id VARCHAR(64),
	method ENUM('PAYPAL', 'STRIPE') NOT NULL,
	status ENUM('INITIATED', 'PAID', 'FAILED', 'CANCELLED') NOT NULL,
	comment VARCHAR(512),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS user_address_book;

CREATE TABLE user_address_book (
	id INTEGER NOT NULL AUTO_INCREMENT,
	user_id INTEGER NOT NULL,
	name VARCHAR(128) NOT NULL,
	country_code VARCHAR(8) NOT NULL COLLATE utf8mb4_unicode_ci,
	mobile_no VARCHAR(10) NOT NULL COLLATE utf8mb4_unicode_ci,
	email VARCHAR(512) COLLATE utf8mb4_unicode_ci,
	street1 VARCHAR(512) NOT NULL COLLATE utf8mb4_unicode_ci,
	street2 VARCHAR(512) COLLATE utf8mb4_unicode_ci,
	city VARCHAR(128) NOT NULL COLLATE utf8mb4_unicode_ci,
	state VARCHAR(128) NOT NULL COLLATE utf8mb4_unicode_ci,
	country VARCHAR(128) NOT NULL COLLATE utf8mb4_unicode_ci,
	zip_code VARCHAR(128) NOT NULL COLLATE utf8mb4_unicode_ci,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS user_basket;

CREATE TABLE user_basket (
	user_id INTEGER NOT NULL,
	variation_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
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
USE cric_shop_api;

DROP TABLE IF EXISTS user_order;

CREATE TABLE user_order (
	id INTEGER NOT NULL AUTO_INCREMENT,
	user_id INTEGER NOT NULL,
	product_price DECIMAL NOT NULL,
	product_discount DECIMAL NOT NULL DEFAULT 0,
	shipping_price DECIMAL,
	shipping_discount DECIMAL NOT NULL DEFAULT 0,
	price DECIMAL,
	dicount DECIMAL NOT NULL DEFAULT 0,
	price_after_discount DECIMAL,
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
USE cric_shop_api;

DROP TABLE IF EXISTS user_order_book;

CREATE TABLE user_order_book (
	order_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	variation_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	product_price DECIMAL NOT NULL,
	product_discount DECIMAL NOT NULL DEFAULT 0,
	total_price DECIMAL NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS user_transaction;

CREATE TABLE user_transaction (
	id INTEGER NOT NULL AUTO_INCREMENT,
	ref_id INTEGER NOT NULL,
	type ENUM('BOOKING', 'ORDER') NOT NULL,
	total DECIMAL NOT NULL,
	method ENUM('PAYPAL', 'STRIPE') NOT NULL,
	status ENUM(
		'CREATED',
		'INITIATED',
		'CONFIRMED',
		'CANCELLED',
		'FAILED'
	) NOT NULL DEFAULT 'CREATED',
	payment_ref_id VARCHAR(512),
	payment_ref_token VARCHAR(512),
	payment_error VARCHAR(1024),
	remarks VARCHAR(512),
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cric_shop_api;

DROP TABLE IF EXISTS user_wishlist;

CREATE TABLE user_wishlist (
	user_id INTEGER NOT NULL,
	variation_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;