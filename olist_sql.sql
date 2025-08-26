
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

/* comparing the number of null and non-null values */
/*
SELECT 
    COUNT(*) AS total_rows,
    COUNT(order_id) AS order_id_not_null,
    COUNT(customer_id) AS customer_id_not_null,
    COUNT(order_status) AS order_status_not_null,
    COUNT(order_purchase_timestamp) AS order_purchase_timestamp_not_null,
    COUNT(order_delivered_carrier_date) AS order_delivered_carrier_date_not_null,
    COUNT(order_delivered_customer_date) AS order_delivered_customer_date_not_null,
    COUNT(order_estimated_delivery_date) AS order_estimated_delivery_date_not_null,
    COUNT(order_item_id) AS order_item_id_not_null, 
    COUNT(product_id) AS product_id_not_null, 
    COUNT(seller_id) AS seller_id_not_null, 
    COUNT(shipping_limit_date) AS shipping_limit_date_not_null, 
    COUNT(price) AS price_not_null,
    COUNT(freight_value) AS freight_value_not_null,
    COUNT(payment_sequential) AS payment_sequential_not_null, 
    COUNT(payment_type) AS payment_type_not_null,
    COUNT(payment_installments) AS payment_installments_not_null,
    COUNT(payment_value) AS payment_value_not_null,
    COUNT(review_id) AS review_id_not_null,
    COUNT(review_score) AS review_score_not_null,
    COUNT(review_creation_date) AS review_creation_date_not_null,
    COUNT(review_answer_timestamp) AS review_answer_timestamp_not_null,
    COUNT(customer_unique_id) AS customer_unique_id_not_null,
    COUNT(customer_city) AS customer_city_not_null,
    COUNT(customer_state) AS customer_state_not_null,
    COUNT(product_weight_g) AS product_weight_g_not_null,
    COUNT(product_length_cm) AS product_length_cm_not_null,
    COUNT(product_height_cm) AS product_height_cm_not_null,
    COUNT(product_width_cm) AS product_width_cm_not_null,
    COUNT(product_category_name_english) AS product_category_name_english_not_null,
    COUNT(seller_city) AS seller_city_not_null,
    COUNT(seller_state) AS seller_state_not_null
FROM olist_data;
*/

/* Check which rows has null values */
/*
SELECT *
FROM olist_data
WHERE order_id is NULL
    or customer_id is NULL
    or order_status is NULL
    or order_purchase_timestamp is NULL
    or order_delivered_carrier_date is NULL
    or order_delivered_customer_date is NULL
    or order_estimated_delivery_date is NULL
    or order_item_id is NULL
    or product_id is NULL
    or seller_id is NULL
    or shipping_limit_date is NULL
    or price is NULL
    or freight_value is NULL
    or payment_sequential is NULL
    or payment_type is NULL
    or payment_installments is NULL
    or payment_value is NULL
    or review_id is NULL
    or review_score is NULL
    or review_creation_date is NULL
    or review_answer_timestamp is NULL
    or customer_unique_id is NULL
    or customer_city is NULL
    or customer_state is NULL
    or product_weight_g is NULL
    or product_length_cm is NULL
    or product_height_cm is NULL
    or product_width_cm is NULL
    or product_category_name_english is NULL
    or seller_city is NULL
    or seller_state is NULL;
*/


/* removing rows from some columns with null values*/

/*
DELETE FROM olist_data
WHERE  order_item_id is NULL
    or product_id is NULL
    or seller_id is NULL
    or shipping_limit_date is NULL
    or price is NULL 
    or freight_value is NULL  
    or seller_city is NULL 
    or seller_state is NULL;

*/

/* Looking at duplicate values */

/*
SELECT order_id, COUNT(*) as row_count, COUNT(DISTINCT order_item_id) as unique_items  
FROM olist_data
GROUP BY order_id
HAVING COUNT(*)>1
*/

/*
SELECT order_id, COUNT(*) as row_count, COUNT(DISTINCT order_item_id) as unique_items,
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT order_item_id) THEN 'No duplicate rows'
        WHEN COUNT(*) > COUNT(DISTINCT order_item_id) THEN 'Duplicate rows present'
        ELSE 'unexpected condition'
    END 
FROM olist_data
GROUP BY order_id    
*/


/* Using partition by to select rows */
WITH ranked AS (
SELECT ctid,
    ROW_NUMBER() OVER (PARTITION BY order_id, order_item_id ORDER BY ctid) as rn
)
FROM olist_data
