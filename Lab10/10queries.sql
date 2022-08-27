USE BikeStores


SELECT * FROM production.stocks
wHERE quantity > 20;


SELECT product_name FROM production.products
WHERE model_year= '2016' AND list_price > 3000;

SELECT COUNT(order_id)
FROM
(
SELECT order_id
 FROM sales.orders
 GROUP BY order_id
 HAVING COUNT(DISTINCT (order_date)) > 1
) t1


SELECT Customer_ID,First_Name as CustomerName
FROM sales.customers 
WHERE customer_ID in
   (SELECT Customer_ID
	FROM sales.orders
	WHERE Shipped_Date > Required_Date);

SELECT  store_id, sum(quantity) As totalquan
FROM production.stocks
GROUP BY store_id
HAVING COUNT(product_id) > 2



SELECT Product_Name 
FROM production.Products 
WHERE Product_ID IN(SELECT Product_ID 
FROM sales.order_items 
WHERE Order_ID IN (SELECT Order_ID FROM sales.Orders WHERE YEAR(Order_Date)=2016) ) ;



SELECT STAFF_ID, STORE_ID, COUNT(*)
FROM sales.staffs
GROUP BY STAFF_ID,STORE_ID
HAVING COUNT(*) > 1;


SELECT c.first_name, c.last_name, COUNT(*)
FROM sales.customers c
INNER JOIN sales.orders d ON c.customer_id = d.customer_id
WHERE d.order_status >= 3
AND d.order_date >= '2016-01-01'
AND d.order_date <= '2016-05-30'
GROUP BY c.first_name, c.last_name
ORDER BY COUNT(*) DESC;

SELECT
co.order_date AS order_day,
COUNT(DISTINCT co.order_id) AS num_orders,
COUNT(co.customer_id) AS custs,
SUM(ol.list_price) AS total_price
FROM sales.orders co
INNER JOIN sales.order_items ol ON co.order_id = ol.order_id
GROUP BY co.order_date
ORDER BY co.order_date ASC;

SELECT
order_day,
COUNT(DISTINCT order_id) AS num_orders,

SUM(COUNT(customer_id)) OVER (
ORDER BY order_day
) AS running_total
FROM (
  SELECT
  co.order_date AS order_day,
  co.order_id,
  co.customer_id,
  ol.list_price
  FROM sales.orders co
  INNER JOIN sales.order_items ol ON co.order_id = ol.order_id
) sub
GROUP BY order_day
ORDER BY order_day ASC;

