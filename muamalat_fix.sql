SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM productcategory;
SELECT * FROM customers_orders;
SELECT * FROM product_productcategory;


SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM tabel_master2;
SELECT COUNT(*) FROM customers_orders;
SELECT COUNT(*) FROM product_productcategory;

-- JOIN 1 CUSTOMER - ORDER

CREATE TABLE customers_orders AS
	SELECT
		cs.CustomerID,
		cs.CustomerEmail,
		cs.CustomerCity,
		od.OrderDate,
		od.ProdNumber,
		od.Quantity,
        od.OrderID
	FROM customers as cs
	LEFT JOIN orders as od 
	ON od.OrderID = cs.CustomerID;

----- -- JOIN 2 PRODUCT - PRODUCTCATEGORY

CREATE TABLE product_productcategory
	SELECT
		pd.ProdNumber,
		pd.ProdName,
		pd.Price,
		pc.CategoryName
	FROM products as pd
	LEFT JOIN productcategory as pc
	ON pd.CategoryID = pc.CategoryID;

-- 	PENGGABUNGAN HASIL JOIN (MASTER_TABLE)

CREATE TABLE master_table AS
	SELECT 
		co.OrderDate as order_date, 
		ppc.CategoryName as category_name,
		ppc.ProdName as product_name,
		ppc.Price as product_price,
		co.Quantity as order_qty,
		co.CustomerEmail as cust_email,
		co.CustomerCity as cust_city
	FROM customers_orders co
	LEFT JOIN product_productcategory ppc ON co.ProdNumber = ppc.ProdNumber;
    
ALTER TABLE master_table
ADD COLUMN total_sales INT;

UPDATE master_table
SET total_sales = order_qty * product_price;

SELECT * FROM master_table;
SELECT count(*) FROM master_table;