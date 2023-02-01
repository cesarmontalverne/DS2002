-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
select count(*) as count_prod 
from northwind.products;

-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
select product_name, quantity_per_unit from northwind.products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
select id,product_name from northwind.products
where discontinued<>1;

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
select id,product_name from northwind.products
where discontinued=1;

-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
select product_name, list_price
from northwind.products  
where list_price=(select min(list_price) from northwind.products) ||
list_price=(select max(list_price) from northwind.products)
order by list_price desc;

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
select id, product_name, list_price from northwind.products
where list_price<20
order by list_price desc;

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
select id, product_name, list_price from northwind.products
where list_price<20 and list_price>15;


-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
select product_name,list_price from northwind.products
where list_price > (select avg(list_price) from northwind.products)
order by list_price desc;

-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
select product_name, list_price from northwind.products
order by list_price desc limit 10;

-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
select discontinued,count(*) from northwind.products
group by discontinued;
-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
-- I assumed reorder_level is the lower bound stock
-- the query shows which orders might not be fulfilled because units ordered > lower_bound_stock
select product_name,quantity as units_on_order,
	reorder_level as lower_bound_stock
from northwind.products as products INNER JOIN northwind.order_details as orders
         on orders.product_id = products.id 
where reorder_level<quantity;




-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
select company, address, state_province, city, zip_postal_code, country_region 
from northwind.suppliers;


-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
-- I'll assume reorder_level is the lower bound for stock.
select category,count(*) from northwind.products where reorder_level<5
group by category;

-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
select category, count(*) from northwind.products
where list_price<20 
group by category;

