/******************************************************
	NAME:           SP_complete_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_complete_booking(?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_booking";
DROP PROCEDURE IF EXISTS SP_complete_booking;

SELECT "Creating PROCEDURE SP_complete_booking";
DELIMITER //

CREATE PROCEDURE SP_complete_booking(
	IN booking_id INTEGER,
	IN status ENUM(
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	)
) 
BEGIN
	UPDATE lane_booking SET lane_booking.status = status
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_booking created successfully";
/******************************************************
	NAME:           SP_complete_order
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_complete_order(?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_order";
DROP PROCEDURE IF EXISTS SP_complete_order;

SELECT "Creating PROCEDURE SP_complete_order";
DELIMITER //

CREATE PROCEDURE SP_complete_order(
	IN order_id INTEGER,
	IN status ENUM(
		'CONFIRMED',
		'PENDING',
		'CANCELLED',
		'FAILED',
		'COMPLETED'
	)
) 
BEGIN
	UPDATE user_order SET user_order.status = status
	WHERE user_order.id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_order created successfully";
/******************************************************
	NAME:           SP_complete_transaction
 	FUNCTION:       Completes a transaction
 	MySql > CALL SP_complete_transaction(?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_complete_transaction";
DROP PROCEDURE IF EXISTS SP_complete_transaction;

SELECT "Creating PROCEDURE SP_complete_transaction";
DELIMITER //

CREATE PROCEDURE SP_complete_transaction(
	IN payment_ref_id VARCHAR(512),
	IN payment_ref_token VARCHAR(512),
	IN payment_status ENUM('CONFIRMED','CANCELLED', 'FAILED'),
	IN payment_error VARCHAR(1024)
) 
BEGIN
	IF payment_ref_id IS NOT NULL THEN
		UPDATE user_transaction SET 
		user_transaction.payment_error = payment_error, 
		user_transaction.status = payment_status
		WHERE user_transaction.payment_ref_id = payment_ref_id;

		SELECT user_transaction.id, user_transaction.ref_id, user_transaction.type 
		FROM user_transaction
		WHERE user_transaction.payment_ref_id = payment_ref_id;
	ELSE
		UPDATE user_transaction SET 
		user_transaction.payment_error = payment_error, 
		user_transaction.status = payment_status
		WHERE user_transaction.payment_ref_token = payment_ref_token;

		SELECT user_transaction.id, user_transaction.ref_id, user_transaction.type 
		FROM user_transaction
		WHERE user_transaction.payment_ref_token = payment_ref_token;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_complete_transaction created successfully";
/******************************************************
	NAME:           SP_create_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_booking(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_booking";
DROP PROCEDURE IF EXISTS SP_create_booking;

SELECT "Creating PROCEDURE SP_create_booking";
DELIMITER //

CREATE PROCEDURE SP_create_booking(
	IN lane_id INTEGER,
	IN user_id INTEGER,
	IN team_name VARCHAR(128),
	IN no_of_member INTEGER,
	IN price DECIMAL(10,2),
	IN tax DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	INSERT INTO lane_booking(lane_id,user_id,team_name,no_of_member,price,tax,price_after_discount,started_at,finished_at) VALUES
	(lane_id,user_id,team_name,no_of_member,price,tax,price_after_discount,started_at,finished_at);
	SELECT LAST_INSERT_ID() AS booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_booking created successfully";
/******************************************************
	NAME:           SP_create_shipment
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_create_shipment(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_shipment";
DROP PROCEDURE IF EXISTS SP_create_shipment;

SELECT "Creating PROCEDURE SP_create_shipment";
DELIMITER //

CREATE PROCEDURE SP_create_shipment(
	IN order_id INTEGER,
	IN address_id INTEGER,
	IN price DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN shipment_id VARCHAR(512),
	IN shipment VARCHAR(512)
) 
BEGIN
	INSERT INTO order_shipping(order_id,address_id,price,price_after_discount,shipment_id,shipment) VALUES
	(order_id,address_id,price,price_after_discount,shipment_id,shipment);
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_shipment created successfully";
/******************************************************
	NAME:           SP_create_transaction
 	FUNCTION:       Create a new transaction
 	MySql > CALL SP_create_transaction(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_transaction";
DROP PROCEDURE IF EXISTS SP_create_transaction;

SELECT "Creating PROCEDURE SP_create_transaction";
DELIMITER //

CREATE PROCEDURE SP_create_transaction(
	IN ref_id INTEGER,
	IN type ENUM('BOOKING', 'ORDER'),
	IN total DECIMAL,
	IN method ENUM('PAYPAL', 'STRIPE')
) 
BEGIN
	INSERT INTO user_transaction(ref_id,type,total,method) VALUES
	(ref_id,type,total,method);
	SELECT LAST_INSERT_ID() AS txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_transaction created successfully";
/******************************************************
	NAME:           SP_create_user_address
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_user_address(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_user_address";
DROP PROCEDURE IF EXISTS SP_create_user_address;

SELECT "Creating PROCEDURE SP_create_user_address";
DELIMITER //

CREATE PROCEDURE SP_create_user_address(
	IN user_id INTEGER,
	IN name VARCHAR(128),
	IN country_code VARCHAR(8),
	IN mobile_no VARCHAR(10),
	IN email VARCHAR(512),
	IN street1 VARCHAR(512),
	IN street2 VARCHAR(512),
	IN city VARCHAR(128),
	IN state VARCHAR(128),
	IN country VARCHAR(128),
	IN zip_code VARCHAR(128)
) 
BEGIN
	INSERT INTO user_address_book(user_id,name,country_code,mobile_no,email,street1,street2,city,state,country,zip_code) VALUES
	(user_id,name,country_code,mobile_no,email,street1,street2,city,state,country,zip_code);
	SELECT LAST_INSERT_ID() AS address_id; 
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_user_address created successfully";
/******************************************************
	NAME:           SP_create_user_order
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_create_user_order(?,?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_create_user_order";
DROP PROCEDURE IF EXISTS SP_create_user_order;

SELECT "Creating PROCEDURE SP_create_user_order";
DELIMITER //

CREATE PROCEDURE SP_create_user_order(
	IN user_id INTEGER,
	IN product_price DECIMAL(10,2),
	IN product_discount DECIMAL(10,2),
	IN shipping_price DECIMAL(10,2),
	IN shipping_discount DECIMAL(10,2),
	IN price DECIMAL(10,2),
	IN dicount DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2)
) 
BEGIN
	INSERT INTO user_order(user_id,product_price,product_discount,shipping_price,shipping_discount,price,dicount,price_after_discount) VALUES
	(user_id,product_price,product_discount,shipping_price,shipping_discount,price,dicount,price_after_discount);
	SELECT LAST_INSERT_ID() AS order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_create_user_order created successfully";
/******************************************************
	NAME:           SP_fetch_basket
 	FUNCTION:       Fetch basket
 	MySql > CALL SP_fetch_basket(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_basket";
DROP PROCEDURE IF EXISTS SP_fetch_basket;

SELECT "Creating PROCEDURE SP_fetch_basket";
DELIMITER //

CREATE PROCEDURE SP_fetch_basket(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_basket_query = "SELECT 
		products.id, products.name, products.image, 
		products.weight, 
		products.product_custom_field1 AS length, 
		products.product_custom_field2 AS width, 
		products.product_custom_field3 AS depth,
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available,
		user_basket.quantity
	FROM user_basket 
	INNER JOIN variations 
		ON user_basket.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_basket.user_id = ?
	ORDER BY user_basket.created_at DESC";

	PREPARE stmt FROM @fetch_basket_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_basket created successfully";
/******************************************************
	NAME:           SP_fetch_bookings
 	FUNCTION:       Fetch cart
 	MySql > CALL SP_fetch_bookings(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_bookings";
DROP PROCEDURE IF EXISTS SP_fetch_bookings;

SELECT "Creating PROCEDURE SP_fetch_bookings";
DELIMITER //

CREATE PROCEDURE SP_fetch_bookings(
	IN user_id INTEGER
) 
BEGIN
	SELECT lane_booking.id, lane_booking.created_at, lane_booking.status, lane.name, lane.image, 
	lane_booking.team_name, lane_booking.no_of_member, 
	lane_booking.price, lane_booking.price_after_discount,
	lane_booking.started_at, lane_booking.finished_at,
	lane_booking.lane_id
	FROM lane_booking INNER JOIN lane
		ON	lane.id = lane_booking.lane_id
	WHERE lane_booking.user_id = user_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_bookings created successfully";
/******************************************************
	NAME:           SP_fetch_booking_cost
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_booking_cost(?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_booking_cost";
DROP PROCEDURE IF EXISTS SP_fetch_booking_cost;

SELECT "Creating PROCEDURE SP_fetch_booking_cost";
DELIMITER //

CREATE PROCEDURE SP_fetch_booking_cost(
	IN laneId INTEGER,
	IN dayOfWeek INTEGER,
	IN noOfPerson INTEGER
) 
BEGIN
	SELECT * FROM lane_pricing
	WHERE lane_pricing.lane_id = laneId AND
	lane_pricing.day_of_week = dayOfWeek AND
	lane_pricing.no_of_person <= noOfPerson
	ORDER BY lane_pricing.no_of_person DESC;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_booking_cost created successfully";
/******************************************************
	NAME:           SP_fetch_booking_detail
 	FUNCTION:       Fetch cart
 	MySql > CALL SP_fetch_booking_detail(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_booking_detail";
DROP PROCEDURE IF EXISTS SP_fetch_booking_detail;

SELECT "Creating PROCEDURE SP_fetch_booking_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_booking_detail(
	IN booking_id INTEGER
) 
BEGIN
	SELECT lane_booking.id, lane_booking.created_at, lane_booking.status, lane.name, lane.image, 
	lane_booking.team_name, lane_booking.no_of_member, 
	lane_booking.price, lane_booking.price_after_discount,
	lane_booking.started_at, lane_booking.finished_at,
	lane_booking.lane_id
	FROM lane_booking INNER JOIN lane
		ON	lane.id = lane_booking.lane_id
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_booking_detail created successfully";
/******************************************************
	NAME:           SP_fetch_cart
 	FUNCTION:       Fetch cart
 	MySql > CALL SP_fetch_cart(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_cart";
DROP PROCEDURE IF EXISTS SP_fetch_cart;

SELECT "Creating PROCEDURE SP_fetch_cart";
DELIMITER //

CREATE PROCEDURE SP_fetch_cart(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_cart_query = "SELECT 
		products.id, products.name, products.image, 
		products.weight, 
		products.product_custom_field1 AS length, 
		products.product_custom_field2 AS width, 
		products.product_custom_field3 AS depth, 
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available,
		user_cart.quantity,
		user_cart.from_basket
	FROM user_cart 
	INNER JOIN variations 
		ON user_cart.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_cart.user_id = ?
	ORDER BY user_cart.created_at DESC";

	PREPARE stmt FROM @fetch_cart_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_cart created successfully";
/******************************************************
	NAME:           SP_fetch_categories
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_categories() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_categories";
DROP PROCEDURE IF EXISTS SP_fetch_categories;

SELECT "Creating PROCEDURE SP_fetch_categories";
DELIMITER //

CREATE PROCEDURE SP_fetch_categories(
) 
BEGIN
	SELECT * FROM categories 
	WHERE parent_id = 0
	ORDER BY id ASC;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_categories created successfully";
/******************************************************
	NAME:           SP_fetch_category_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_category_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_category_detail";
DROP PROCEDURE IF EXISTS SP_fetch_category_detail;

SELECT "Creating PROCEDURE SP_fetch_category_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_category_detail(
	IN category_id INTEGER
) 
BEGIN
	SELECT categories.id, categories.name, categories.image, categories.parent_id,
	T.id AS sub_category_id, T.name AS sub_category_name
	FROM categories LEFT JOIN categories T 
		ON categories.id = T.parent_id
	WHERE categories.id = category_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_category_detail created successfully";
/******************************************************
	NAME:           SP_fetch_category_filter
 	FUNCTION:       Fetch category filter
 	MySql > CALL SP_fetch_category_filter(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_category_filter";
DROP PROCEDURE IF EXISTS SP_fetch_category_filter;

SELECT "Creating PROCEDURE SP_fetch_category_filter";
DELIMITER //

CREATE PROCEDURE SP_fetch_category_filter(
	IN category_id INTEGER,
	IN filter_keys VARCHAR(1024)
) 
BEGIN
	SET @caterory_id = category_id;
	SET @filter_keys = filter_keys;

	SET @fetch_category_filter_query = "SELECT ? FROM variations 
	GROUP BY ?";

	PREPARE stmt FROM @fetch_category_filter_query;
	EXECUTE stmt USING @filter_keys, @filter_keys;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_category_filter created successfully";
/******************************************************
	NAME:           SP_fetch_lanes
 	FUNCTION:       Fetch lanes
 	MySql > CALL SP_fetch_lanes() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lanes";
DROP PROCEDURE IF EXISTS SP_fetch_lanes;

SELECT "Creating PROCEDURE SP_fetch_lanes";
DELIMITER //

CREATE PROCEDURE SP_fetch_lanes(
) 
BEGIN
	SELECT * FROM lane;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lanes created successfully";
/******************************************************
	NAME:           SP_fetch_lane_bookings
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_lane_bookings(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lane_bookings";
DROP PROCEDURE IF EXISTS SP_fetch_lane_bookings;

SELECT "Creating PROCEDURE SP_fetch_lane_bookings";
DELIMITER //

CREATE PROCEDURE SP_fetch_lane_bookings(
	IN lane_id INTEGER
) 
BEGIN
	SELECT lane_booking.started_at, lane_booking.finished_at
	FROM lane_booking
	WHERE
	lane_booking.lane_id = lane_id
	AND lane_booking.status IN ('CONFIRMED','INITIATED','PENDING','UPDATED')
	AND lane_booking.started_at >= UNIX_TIMESTAMP()*1000;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lane_bookings created successfully";
/******************************************************
	NAME:           SP_fetch_lane_detail
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_lane_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_lane_detail";
DROP PROCEDURE IF EXISTS SP_fetch_lane_detail;

SELECT "Creating PROCEDURE SP_fetch_lane_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_lane_detail(
	IN lane_id INTEGER
) 
BEGIN
	SELECT * from lane WHERE lane.id = lane_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_lane_detail created successfully";
/******************************************************
	NAME:           SP_fetch_orders
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_orders() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_orders";
DROP PROCEDURE IF EXISTS SP_fetch_orders;

SELECT "Creating PROCEDURE SP_fetch_orders";
DELIMITER //

CREATE PROCEDURE SP_fetch_orders(
	IN user_id INTEGER
) 
BEGIN
	SELECT user_order.id, 
		user_order.status,
		user_order.created_at,
		(user_order.product_price - user_order.product_discount) AS product_price,
		(user_order.shipping_price - user_order.shipping_discount) AS shipping_cost,
		user_order.price_after_discount AS order_total,
		order_shipping.tracking_URL
	FROM user_order 
	INNER JOIN order_shipping
		ON order_shipping.order_id = user_order.id
	WHERE user_order.user_id = user_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_orders created successfully";
/******************************************************
	NAME:           SP_fetch_order_address
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_order_address(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_order_address";
DROP PROCEDURE IF EXISTS SP_fetch_order_address;

SELECT "Creating PROCEDURE SP_fetch_order_address";
DELIMITER //

CREATE PROCEDURE SP_fetch_order_address(
	IN track_no VARCHAR(512)
) 
BEGIN
	SELECT user_address_book.country_code, user_address_book.mobile_no, user_address_book.email FROM order_shipping 
	INNER JOIN user_address_book 
		ON order_shipping.address_id = user_address_book.id
	WHERE order_shipping.tracking_no = track_no;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_order_address created successfully";
/******************************************************
	NAME:           SP_fetch_order_detail
 	FUNCTION:       Fetch categories
 	MySql > CALL SP_fetch_order_detail() 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_order_detail";
DROP PROCEDURE IF EXISTS SP_fetch_order_detail;

SELECT "Creating PROCEDURE SP_fetch_order_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_order_detail(
	IN order_id INTEGER
) 
BEGIN
	SELECT user_order.id, 
		user_order.status,
		user_order.created_at,
		products.name, products.image, 
		user_order_book.variation_id,
		user_order_book.quantity, 
		user_order_book.product_price, 
		(user_order.shipping_price - user_order.shipping_discount) AS shipping_cost,
		user_order.price_after_discount AS order_total,
		order_shipping.tracking_URL,
		user_address_book.name AS receiver_name, user_address_book.country_code,
		user_address_book.mobile_no, user_address_book.email,
		user_address_book.street1, user_address_book.city, user_address_book.state, user_address_book.country,
		user_address_book.zip_code
	FROM user_order 
	INNER JOIN user_order_book 
		ON user_order.id = user_order_book.order_id
	INNER JOIN variations
		ON user_order_book.variation_id = variations.id
	INNER JOIN products 
		ON variations.product_id = products.id 
	INNER JOIN order_shipping
		ON order_shipping.order_id = user_order.id
	INNER JOIN user_address_book
		ON user_address_book.id = order_shipping.address_id
	WHERE user_order.id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_order_detail created successfully";
/******************************************************
	NAME:           SP_fetch_products
 	FUNCTION:       Fetch products
 	MySql > CALL SP_fetch_products(?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_products";
DROP PROCEDURE IF EXISTS SP_fetch_products;

SELECT "Creating PROCEDURE SP_fetch_products";
DELIMITER //

CREATE PROCEDURE SP_fetch_products(
	IN caterory_ids VARCHAR(128),
	IN subcategory_ids VARCHAR(128),
	IN product_name VARCHAR(1024),
	IN brand_name VARCHAR(1024),
	IN ideal_for VARCHAR(1024),
	IN material_type VARCHAR(1024),
	IN handle_type VARCHAR(1024),
	IN style_type VARCHAR(1024),
	IN size VARCHAR(1024),
	IN color VARCHAR(1024),
	IN price_gte INTEGER,
	IN price_lte INTEGER,
	IN price_asc BOOLEAN,
	IN rating_desc BOOLEAN,
	IN newest_first BOOLEAN,
	IN page_no INTEGER,
	IN per_page INTEGER
) 
BEGIN
	SET @caterory_ids = caterory_ids;
	SET @subcategory_ids = subcategory_ids;
	SET @product_name = product_name;
	IF @product_name IS NOT NULL THEN	
		SET @product_name = CONCAT('%',@product_name,'%');
	END IF;
	SET @brand_name = brand_name;
	SET @ideal_for = ideal_for;
	SET @material_type = material_type;
	SET @handle_type = handle_type;
	SET @style_type = style_type;
	SET @size = size;
	SET @color = color;
	SET @price_gte = price_gte;
	SET @price_lte = price_lte;
	SET @price_order = "variations.sell_price_inc_tax ASC";
	SET @rating_order = "product.rating DESC";
	SET @creation_order = "variations.created_at DESC";
	SET @offset = 0;
	SET @limit = 1000;

	IF price_asc IS FALSE THEN 
		SET @price_order = "variations.sell_price_inc_tax DESC";
	END IF;
	IF rating_desc IS FALSE THEN 
		SET @rating_order = "product.rating ASC";
	END IF;
	IF newest_first IS FALSE THEN 
		SET @creation_order = "variations.created_at ASC";
	END IF;
	IF page_no IS NOT NULL AND page_no > 0 THEN 
		SET @limit = page_no;
	END IF;
	IF page_no IS NOT NULL AND page_no > 0 THEN 
		SET @offset = page_no * @limit;
	END IF;

	SET @fetch_products_query = "SELECT products.id, products.name, products.image,
		variations.id AS variation_id, variations.name AS variation_name,
        variations.sell_price_inc_tax AS regular_price,
        MIN(variations.sell_price_inc_tax) AS sale_price,
		variation_location_details.qty_available
	FROM variations
	INNER JOIN products 
		ON variations.product_id = products.id 
	INNER JOIN brands
		ON products.brand_id = brands.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE 
		(( ? IS NULL AND ? IS NULL ) OR 
		( ? IS NOT NULL AND products.sub_category_id IN (?) ) OR 
		( ? IS NOT NULL AND products.category_id IN (?) )) AND 
		( ? IS NULL OR products.name LIKE ?) AND
		( ? IS NULL OR brands.name IN (?)) AND
		( ? IS NULL OR products.product_filter_custom_field1 IN (?)) AND
		( ? IS NULL OR products.product_filter_custom_field2 IN (?)) AND
		( ? IS NULL OR products.product_filter_custom_field3 IN (?)) AND
		( ? IS NULL OR products.product_filter_custom_field4 IN (?)) AND
		( ? IS NULL OR TRIM(SUBSTRING(variations.name,1,LOCATE(? ,variations.name)-1)) IN (?)) AND 
		( ? IS NULL OR TRIM(SUBSTRING(variations.name,LOCATE(? ,variations.name)+1)) IN (?)) AND		
		( ? IS NULL OR variations.sell_price_inc_tax >= ? ) AND		
		( ? IS NULL OR variations.sell_price_inc_tax <= ? )		
	GROUP BY products.id 
	ORDER BY 
		?, ?
	LIMIT ?, ?";

	PREPARE stmt FROM @fetch_products_query;
	EXECUTE stmt USING @caterory_ids, @subcategory_ids, @subcategory_ids, @subcategory_ids, @caterory_ids, @caterory_ids, 
	@product_name, @product_name,
	@brand_name, @brand_name,
	@ideal_for, @ideal_for,
	@material_type, @material_type,
	@handle_type, @handle_type,
	@style_type, @style_type,
	@size, ",", @size,
	@color, ",", @color,
	@price_gte, @price_gte,
	@price_lte, @price_lte,
	@price_order, @creation_order, @offset, @limit;
	DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_products created successfully";
/******************************************************
	NAME:           SP_fetch_products_filter
 	FUNCTION:       Fetch products
 	MySql > CALL SP_fetch_products_filter(?,?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_products_filter";
DROP PROCEDURE IF EXISTS SP_fetch_products_filter;

SELECT "Creating PROCEDURE SP_fetch_products_filter";
DELIMITER //

CREATE PROCEDURE SP_fetch_products_filter(
	IN cat_id VARCHAR(128),
	IN sub_cat_id VARCHAR(128)
) 
BEGIN
	-- filter size
	SELECT brands.name AS brand, 
	CASE
		WHEN variations.variation_value_id IS NULL THEN NULL
		ELSE SUBSTRING(variations.name,1,POSITION("," IN variations.name)-1)
	END AS size,
	CASE
		WHEN variations.variation_value_id IS NULL THEN NULL
		ELSE SUBSTRING(variations.name,POSITION("," IN variations.name)+1)
	END AS color, 
	products.product_filter_custom_field1 AS ideal_for, 
	products.product_filter_custom_field2 AS material_type, 
	products.product_filter_custom_field3 AS handle_type, 
	products.product_filter_custom_field4 AS style_type, 
	MAX(variations.sell_price_inc_tax) AS price 
	FROM products INNER JOIN variations 
		ON products.id = variations.product_id
	INNER JOIN brands 
		ON brands.id = products.brand_id
	WHERE (cat_id IS NOT NULL AND products.category_id = cat_id) OR 
	(sub_cat_id IS NOT NULL AND products.sub_category_id = sub_cat_id)
	GROUP BY brands.name, 
	SUBSTRING(variations.name,1,POSITION("," IN variations.name)-1), 
	SUBSTRING(variations.name,POSITION("," IN variations.name)+1), 
	products.product_filter_custom_field1, products.product_filter_custom_field2, products.product_filter_custom_field3, products.product_filter_custom_field4;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_products_filter created successfully";
/******************************************************
	NAME:           SP_fetch_product_detail
 	FUNCTION:       Fetch product detail
 	MySql > CALL SP_fetch_product_detail(?) 
	
 	FIRST CREATED:  20211116
 	UPDATED:        20211116
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_product_detail";
DROP PROCEDURE IF EXISTS SP_fetch_product_detail;

SELECT "Creating PROCEDURE SP_fetch_product_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_product_detail(
	IN product_id INTEGER
) 
BEGIN
	SET @product_id = product_id;
	SET @fetch_product_detail_query = "SELECT 
		products.id, products.name, products.product_description, products.long_description, products.additional_information,
		products.image, products.product_images AS gallery, 
		products.weight, 
		products.product_custom_field1 AS length, products.product_custom_field2 AS height, products.product_custom_field3 AS width,
		products.product_filter_custom_field1 AS ideal_for, 
		products.product_filter_custom_field2 AS material_type, 
		products.product_filter_custom_field3 AS handle_type, 
		products.product_filter_custom_field4 AS style_type, 
		units.id AS unit_id, units.actual_name AS unit_name,
		brands.id AS brand_id, brands.name AS brand_name,
		categories.id AS category_id, categories.name AS category_name,
		variations.id AS variation_id, variations.name AS variation_name,
		TRIM(SUBSTRING(variations.name,1,LOCATE(? ,variations.name)-1)) AS size,
		TRIM(SUBSTRING(variations.name,LOCATE(? ,variations.name)+1)) AS color,
		variations.sell_price_inc_tax AS regular_price, variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available
	FROM products 
	LEFT JOIN business_locations 
		ON products.business_id = business_locations.id
	LEFT JOIN units
		ON products.unit_id = units.id
	LEFT JOIN brands 
		ON products.brand_id = brands.id
	LEFT JOIN categories 
		ON products.category_id = categories.id
	LEFT JOIN variations
		ON products.id = variations.product_id
	INNER JOIN variation_location_details
		ON variations.id = variation_location_details.variation_id
	WHERE products.id = ?";

	PREPARE stmt FROM @fetch_product_detail_query;
	EXECUTE stmt USING ",",",",@product_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_product_detail created successfully";
/******************************************************
	NAME:           SP_fetch_shipping_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_shipping_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_shipping_detail";
DROP PROCEDURE IF EXISTS SP_fetch_shipping_detail;

SELECT "Creating PROCEDURE SP_fetch_shipping_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_shipping_detail(
	IN order_id INTEGER
) 
BEGIN
	SELECT * FROM order_shipping WHERE order_shipping.order_id = order_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_shipping_detail created successfully";
/******************************************************
	NAME:           SP_fetch_sub_category_detail
 	FUNCTION:       Fetch sub-category detail
 	MySql > CALL SP_fetch_sub_category_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_sub_category_detail";
DROP PROCEDURE IF EXISTS SP_fetch_sub_category_detail;

SELECT "Creating PROCEDURE SP_fetch_sub_category_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_sub_category_detail(
	IN sub_category_id INTEGER
) 
BEGIN
	SELECT * FROM categories 
	WHERE id = sub_category_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_sub_category_detail created successfully";
/******************************************************
	NAME:           SP_fetch_transaction_detail
 	FUNCTION:       Fetch category detail
 	MySql > CALL SP_fetch_transaction_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_transaction_detail";
DROP PROCEDURE IF EXISTS SP_fetch_transaction_detail;

SELECT "Creating PROCEDURE SP_fetch_transaction_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_transaction_detail(
	IN txn_id INTEGER
) 
BEGIN
	SELECT * FROM user_transaction WHERE user_transaction.id = txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_transaction_detail created successfully";
/******************************************************
	NAME:           SP_fetch_user_address
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_user_address(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_user_address";
DROP PROCEDURE IF EXISTS SP_fetch_user_address;

SELECT "Creating PROCEDURE SP_fetch_user_address";
DELIMITER //

CREATE PROCEDURE SP_fetch_user_address(
	IN u_id INTEGER
) 
BEGIN
	SELECT * FROM user_address_book WHERE user_address_book.user_id = u_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_user_address created successfully";
/******************************************************
	NAME:           SP_fetch_user_address_detail
 	FUNCTION:       Fetch lane detail
 	MySql > CALL SP_fetch_user_address_detail(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_user_address_detail";
DROP PROCEDURE IF EXISTS SP_fetch_user_address_detail;

SELECT "Creating PROCEDURE SP_fetch_user_address_detail";
DELIMITER //

CREATE PROCEDURE SP_fetch_user_address_detail(
	IN address_id INTEGER
) 
BEGIN
	SELECT * FROM user_address_book WHERE id = address_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_user_address_detail created successfully";
/******************************************************
	NAME:           SP_fetch_wishlist
 	FUNCTION:       Fetch wishlist
 	MySql > CALL SP_fetch_wishlist(?) 
	
 	FIRST CREATED:  20211118
 	UPDATED:        20211118
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_fetch_wishlist";
DROP PROCEDURE IF EXISTS SP_fetch_wishlist;

SELECT "Creating PROCEDURE SP_fetch_wishlist";
DELIMITER //

CREATE PROCEDURE SP_fetch_wishlist(
	IN user_id INTEGER
) 
BEGIN
	SET @user_id = user_id;

	SET @fetch_wishlist_query = "SELECT 
		products.id, products.name, products.image, 
		variations.id AS variation_id, variations.name AS variation_name, 
		variations.sell_price_inc_tax AS regular_price,
        variations.sell_price_inc_tax AS sale_price,
		variation_location_details.qty_available
	FROM user_wishlist 
	INNER JOIN variations 
		ON user_wishlist.variation_id = variations.id
	INNER JOIN products
		ON variations.product_id = products.id
	INNER JOIN variation_location_details 
		ON variations.id = variation_location_details.variation_id
	WHERE user_wishlist.user_id = ?
	ORDER BY user_wishlist.created_at DESC";

	PREPARE stmt FROM @fetch_wishlist_query;
	EXECUTE stmt USING @user_id;
	DEALLOCATE PREPARE stmt;

END //
DELIMITER ;

SELECT "PROCEDURE SP_fetch_wishlist created successfully";
/******************************************************
	NAME:           SP_initiate_shipment
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_initiate_shipment(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_initiate_shipment";
DROP PROCEDURE IF EXISTS SP_initiate_shipment;

SELECT "Creating PROCEDURE SP_initiate_shipment";
DELIMITER //

CREATE PROCEDURE SP_initiate_shipment(
	IN shipment_id VARCHAR(512),
	IN status ENUM('INITIATED', 'CONFIRMED', 'CANCELLED', 'FAILED'),
	IN transaction_id VARCHAR(512),
	IN shipment_rate VARCHAR(512),
	IN tracking_no VARCHAR(512),
	IN tracking_URL VARCHAR(1024),
	IN label_URL VARCHAR(1024),
	remarks VARCHAR(1024)
) 
BEGIN
	UPDATE order_shipping SET
	order_shipping.status = status,
	order_shipping.transaction_id = transaction_id,
	order_shipping.shipment_rate = shipment_rate,
	order_shipping.tracking_no = tracking_no,
	order_shipping.tracking_URL = tracking_URL,
	order_shipping.label_URL = label_URL,
	order_shipping.remarks = remarks
	WHERE order_shipping.shipment_id = shipment_id; 
END //
DELIMITER ;

SELECT "PROCEDURE SP_initiate_shipment created successfully";
/******************************************************
	NAME:           SP_initiate_transaction
 	FUNCTION:       Initiate a new transaction
 	MySql > CALL SP_initiate_transaction(?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_initiate_transaction";
DROP PROCEDURE IF EXISTS SP_initiate_transaction;

SELECT "Creating PROCEDURE SP_initiate_transaction";
DELIMITER //

CREATE PROCEDURE SP_initiate_transaction(
	IN txn_id INTEGER,
	IN payment_ref_id VARCHAR(512),
	IN payment_ref_token VARCHAR(512)
) 
BEGIN
	UPDATE user_transaction SET 
	user_transaction.payment_ref_id = payment_ref_id,
	user_transaction.payment_ref_token = payment_ref_token,
	user_transaction.status = 'INITIATED'
	WHERE user_transaction.id = txn_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_initiate_transaction created successfully";
/******************************************************
	NAME:           SP_is_lane_available
 	FUNCTION:       Check is lane availabe or not
 	MySql > CALL SP_is_lane_available(?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_is_lane_available";
DROP PROCEDURE IF EXISTS SP_is_lane_available;

SELECT "Creating PROCEDURE SP_is_lane_available";
DELIMITER //

CREATE PROCEDURE SP_is_lane_available(
	IN lane_id INTEGER,
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	SELECT COUNT(lane_booking.id) AS is_available
	FROM lane_booking 
	WHERE
	lane_booking.lane_id = lane_id
	AND lane_booking.status IN('CONFIRMED','INITIATED','PENDING')
	AND lane_booking.started_at <= started_at
	AND lane_booking.finished_at > started_at;
END //
DELIMITER ;

SELECT "PROCEDURE SP_is_lane_available created successfully";
/******************************************************
	NAME:           SP_update_basket
 	FUNCTION:       Update basket
 	MySql > CALL SP_update_basket(?,?,?) 
	
 	FIRST CREATED:  20211123
 	UPDATED:        20211123
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_basket";
DROP PROCEDURE IF EXISTS SP_update_basket;

SELECT "Creating PROCEDURE SP_update_basket";
DELIMITER //

CREATE PROCEDURE SP_update_basket(
	IN user_id INTEGER,
	IN variation_id INTEGER,
	IN quantity INTEGER
) 
BEGIN
	DECLARE is_available BOOLEAN;
	IF quantity = 0 THEN
		DELETE FROM user_basket 
		WHERE user_basket.user_id = user_id
		AND user_basket.variation_id = variation_id;
	ELSE 
		SELECT COUNT(user_basket.variation_id) INTO is_available 
		FROM user_basket
		WHERE user_basket.user_id = user_id
		AND user_basket.variation_id = variation_id;

		IF is_available = 0 THEN 
			INSERT INTO user_basket(user_id,variation_id,quantity) 
			VALUES(user_id,variation_id,quantity);
		ELSE 
			UPDATE user_basket 
			SET user_basket.quantity = quantity
			WHERE user_basket.user_id = user_id
			AND user_basket.variation_id = variation_id;
		END IF;
	END IF;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_basket created successfully";
/******************************************************
	NAME:           SP_update_booking
 	FUNCTION:       Create new bookings
 	MySql > CALL SP_update_booking(?,?,?,?,?,?,?) 
	
 	FIRST CREATED:  20211117
 	UPDATED:        20211117
******************************************************/
USE cric_shop_api;

SELECT "Dropping PROCEDURE SP_update_booking";
DROP PROCEDURE IF EXISTS SP_update_booking;

SELECT "Creating PROCEDURE SP_update_booking";
DELIMITER //

CREATE PROCEDURE SP_update_booking(
	IN booking_id INTEGER,
	IN no_of_member INTEGER,
	IN price DECIMAL(10,2),
	IN tax DECIMAL(10,2),
	IN price_after_discount DECIMAL(10,2),
	IN started_at BIGINT,
	IN finished_at BIGINT
) 
BEGIN
	UPDATE lane_booking SET
	lane_booking.no_of_member = no_of_member,
	lane_booking.started_at = started_at,
	lane_booking.finished_at = finished_at,
	lane_booking.price = price,
	lane_booking.tax = tax,
	lane_booking.price_after_discount = price_after_discount,
	lane_booking.status = 'UPDATED'
	WHERE lane_booking.id = booking_id;
END //
DELIMITER ;

SELECT "PROCEDURE SP_update_booking created successfully";
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