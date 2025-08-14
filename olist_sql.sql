
/***# 1. Creating a new table in the dataset  ***/
/*
CREATE TABLE olist_data (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(100),
    order_purchase_timestamp TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    order_item_id VARCHAR(50),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price DECIMAL,
    freight_value DECIMAL,
    payment_sequential INTEGER,
    payment_type VARCHAR(100),
    payment_installments INTEGER,
    payment_value DECIMAL,
    review_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER,
    customer_city VARCHAR(100),
    customer_state VARCHAR(100),
    product_category_name TEXT,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER,
    product_category_name_english VARCHAR(100),
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state VARCHAR(100)
);

*/



/* # 2. Importing data from the csv file */

/***
COPY olist_data
FROM 'C:/Users/rupak/Main Project/Final_Data.csv'
DELIMITER ','
CSV HEADER;

***/


/***Dropping table in order to restart, due to errors***/

/***
DROP TABLE IF EXISTS olist_data
***/

/*Looking at the table*/

/*
SELECT *
FROM olist_data
*/

/*
# 3. Dropping irrelevant columns 
*/

/***
ALTER TABLE olist_data
    DROP COLUMN IF EXISTS review_comment_title,
    DROP COLUMN IF EXISTS review_comment_message,
    DROP COLUMN IF EXISTS product_name_length,
    DROP COLUMN IF EXISTS product_description_length,
    DROP COLUMN IF EXISTS product_photos_qty
***/    


/* # 4. Selecting two similar columns from the table*/
/*
SELECT product_category_name, product_category_name_english FROM olist_data
*/
/* Dropping the product_category_name column because it is in portuguese  */
/*
ALTER TABLE olist_data
DROP COLUMN IF EXISTS product_category_name;
*/

/* #5. Dropping two more columns from the table */

/*
ALTER TABLE olist_data
    DROP COLUMN IF EXISTS seller_zip_code_prefix,
    DROP COLUMN IF EXISTS customer_zip_code_prefix;

*/