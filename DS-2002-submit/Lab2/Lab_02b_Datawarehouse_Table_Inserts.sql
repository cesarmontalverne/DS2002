-- --------------------------------------------------------------------------------------------------------------
-- TODO: Extract the appropriate data from the northwind database, and INSERT it into the Northwind_DW database.
-- --------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------
-- Populate dim_customers
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.customers;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_customers;


-- ----------------------------------------------
-- Populate dim_employees
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`)
SELECT `employees`.`id`,
    `employees`.`company`,
    `employees`.`last_name`,
    `employees`.`first_name`,
    `employees`.`email_address`,
    `employees`.`job_title`,
    `employees`.`business_phone`,
    `employees`.`home_phone`,
    `employees`.`fax_number`,
    `employees`.`address`,
    `employees`.`city`,
    `employees`.`state_province`,
    `employees`.`zip_postal_code`,
    `employees`.`country_region`,
    `employees`.`web_page`
FROM `northwind`.`employees`;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_employees;


-- ----------------------------------------------
-- Populate dim_products
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_products`
(`product_key`,
`product_code`,
`product_name`,
`standard_cost`,
`list_price`,
`reorder_level`,
`target_level`,
`quantity_per_unit`,
`discontinued`,
`minimum_reorder_quantity`,
`category`)
SELECT `products`.`id`,
`products`.`product_code`,
`products`.`product_name`,
`products`.`standard_cost`,
`products`.`list_price`,
`products`.`reorder_level`,
`products`.`target_level`,
`products`.`quantity_per_unit`,
`products`.`discontinued`,
`products`.`minimum_reorder_quantity`,
`products`.`category` FROM northwind.products;
# TODO: Write a SELECT Statement to Populate the table;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_products;


-- ----------------------------------------------
-- Populate dim_shippers
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `shippers`.`id`,
`shippers`.`company`,
`shippers`.`address`,
`shippers`.`city`,
`shippers`.`state_province`,
`shippers`.`zip_postal_code`,
`shippers`.`country_region` FROM northwind.shippers;
# TODO: Write a SELECT Statement to Populate the table;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.dim_shippers;



-- ----------------------------------------------
-- Populate fact_orders
-- ----------------------------------------------
INSERT INTO `northwind_dw`.`fact_orders`
(`order_key`,
`employee_key`,
`customer_key`,
`order_date`,
`shipped_date`,
`shipper_key`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`product_key`,
`quantity`,
`unit_price`,
`discount`,
`order_status`,
`order_details_status`
)
SELECT `orders`.`id`,
	`orders`.`employee_id`,
	`orders`.`customer_id`,
	`orders`.`order_date`,
	`orders`.`shipped_date`,
	`orders`.`shipper_id`,
	`orders`.`ship_name`,
	`orders`.`ship_address`,
	`orders`.`ship_city`,
	`orders`.`ship_state_province`,
	`orders`.`ship_zip_postal_code`,
	`orders`.`ship_country_region`,
	`orders`.`shipping_fee`,
    `orders`.`taxes`,
	`orders`.`payment_type`,
	`orders`.`paid_date`,
	`orders`.`tax_rate`,
-- order details
	`order_details`.`product_id`,	
	`order_details`.`quantity`,
	`order_details`.`unit_price`,
	`order_details`.`discount`,
-- orders status
	`orders_status`.`status_name`,
-- order details status
	`order_details_status`.`status_name`
FROM ((northwind.orders AS orders RIGHT JOIN northwind.order_details AS order_details
ON orders.id=order_details.order_id) 
INNER JOIN northwind.orders_status AS orders_status
ON orders.status_id=orders_status.id) 
INNER JOIN northwind.order_details_status AS order_details_status
ON order_details.status_id=order_details_status.id;
/* 
--------------------------------------------------------------------------------------------------
TODO: Write a SELECT Statement that:
- JOINS the northwind.orders table with the northwind.orders_status table
- JOINS the northwind.orders with the northwind.order_details table.
--  (TIP: Remember that there is a one-to-many relationship between orders and order_details).
- JOINS the northwind.order_details table with the northwind.order_details_status table.
--------------------------------------------------------------------------------------------------
- The column list I've included in the INSERT INTO clause above should be your guide to which 
- columns you're required to extract from each of the four tables. Pay close attention!
--------------------------------------------------------------------------------------------------
*/
SELECT * FROM northwind.order_details;

-- ----------------------------------------------
-- Validate that the Data was Inserted ----------
-- ----------------------------------------------
SELECT * FROM northwind_dw.fact_orders;