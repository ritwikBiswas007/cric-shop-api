ALTER TABLE contacts
ADD COLUMN `password` VARCHAR(1024),
ADD COLUMN `country_code` VARCHAR(16);

ALTER TABLE categories
ADD COLUMN `image` VARCHAR(1024) NULL;

ALTER TABLE variations
ADD COLUMN `size` VARCHAR(16) NULL,
ADD COLUMN `color` VARCHAR(16) NULL;

ALTER TABLE products
ADD COLUMN `short_description` VARCHAR(512) NULL,
ADD COLUMN `ideal_for` VARCHAR(16) NULL,
ADD COLUMN `handle_type` VARCHAR(16) NULL,
ADD COLUMN `style_type` VARCHAR(16) NULL,
ADD COLUMN `material_type` VARCHAR(16) NULL;

INSERT INTO lane(name,image,rate) VALUES
('Normal Lane','image',5),
('Automatic Lane','image',5);


