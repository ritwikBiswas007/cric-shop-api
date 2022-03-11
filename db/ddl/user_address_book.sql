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