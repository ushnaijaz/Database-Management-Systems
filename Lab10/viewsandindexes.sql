CREATE VIEW product_master
WITH SCHEMABINDING
AS 
SELECT
   p.product_id,
      p.product_name,
      p.brand_id,
      p.category_id,
	  c.category_name
FROM
    production.products p
INNER JOIN production.categories c
    ON c.category_id = p.category_id;


