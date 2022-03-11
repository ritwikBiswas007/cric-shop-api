USE cric_shop_api;

DROP TABLE IF EXISTS lane_pricing;

CREATE TABLE lane_pricing (
	id INTEGER NOT NULL AUTO_INCREMENT,
	lane_id INTEGER NULL,
	duration_in_minute INTEGER NOT NULL,
	day_of_week INTEGER NOT NULL,
	after_hour INTEGER NOT NULL,
	before_hour INTEGER NOT NULL,
	no_of_person INTEGER NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
	deleted_at TIMESTAMP NULL DEFAULT NULL,
	PRIMARY KEY (id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 