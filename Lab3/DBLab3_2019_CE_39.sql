-- 1. Give the names of customers whose orders were delayed. Your answer should have the following schema Customers(CustomerId, CustomerName)
USE Northwind
SELECT a.CustomerID, a.ContactName FROM Customers as a INNER JOIN Orders b ON a.CustomerID=b.CustomerID WHERE ShippedDate > RequiredDate;

-- 2. Give the products details with its supplier company. Products(ProductName, SupplierName)

SELECT a.ProductName, b.CompanyName FROM Products as a INNER JOIN Suppliers as b ON a.SupplierID=b.SupplierID;

-- 3. Give the name of top products which have highest sale in the year 1998.
SELECT top 10 productname
from Products JOIN [Order Details]
ON Products.ProductID= [Order Details].ProductID
JOIN Orders
ON [Order Details].OrderID=Orders.OrderID
WHERE YEAR(OrderDate)='1998'
group by productname
order by SUM(DISTINCT Quantity) DESC
; 

-- 4. Give the name of employees with its manager name. Schema should have the following schema.(EmployeeName, ManagerName)
	
SELECT CONCAT(A.FirstName,' ',A.LastName) AS EmployeeName, CONCAT(B.FirstName,' ',B.LastName) as ManagerName
FROM Employees A
JOIN Employees AS B ON A.ReportsTo=B.EmployeeID

-- 5. Give the full names of managers who have less than two employees.
SELECT CONCAT(B.FirstName,' ',B.LastName) as ManagerName
FROM Employees A
JOIN Employees AS B ON A.ReportsTo=B.EmployeeID WHERE A.ReportsTo < 2;

-- 6: List all the products whose price is more than average price.
SELECT ProductName
FROM Products
WHERE UnitPrice > (Select AVG(UnitPrice)
FROM Products);

-- 7: Find second highest priced product without using TOP statement
SELECT MAX(unitprice) AS Price 
FROM Products 
WHERE unitprice <> (SELECT MAX(unitprice)
FROM Products)
;

--8: Are there any employees who are elder than their managers? List that names of those employees.Schema should look like 
--this Employees(EmployeeName,ManagerName,EmployeeAge,ManagerAge)
SELECT CONCAT(A.FirstName,' ',A.LastName) AS EmployeeName, CONCAT(B.FirstName,' ',B.LastName) as ManagerName, year(getdate())-year(a.BirthDate) 
as EmployeeAge, year(getdate())-year(b.BirthDate) as ManagerAge
FROM Employees A
JOIN Employees AS B ON A.ReportsTo=B.EmployeeID
WHERE A.BirthDate < B.BirthDate


--9. List the names of products which were ordered on 8th August 1997.
SELECT
  Products.ProductName
FROM Products
JOIN [Order Details]
  ON products.ProductID = [Order Details].ProductID
JOIN Orders
  ON orders.orderid = [Order Details].OrderID
WHERE orders.OrderDate='1997-08-08 00:00:00.000'

-- 10. List the names of suppliers whose supplied products were ordered in 1997.
SELECT
  Suppliers.CompanyName
FROM Suppliers
JOIN Products
  ON products.ProductID = Suppliers.SupplierID
JOIN [Order Details]
  ON products.ProductID = [Order Details].ProductID
JOIN Orders
  ON orders.orderid = [Order Details].OrderID
WHERE orders.OrderDate BETWEEN '1997-01-01 00:00:00.000' AND  '1997-12-31 00:00:00.000'

-- 11. How many employees are assigned to Eastern region. Give count.
SELECT COUNT(*) as Num_of_Emp
FROM employees as A
INNER JOIN EmployeeTerritories as B
  ON A.employeeID = B.employeeID
INNER JOIN Territories as C 
  ON  B.TerritoryID = C.TerritoryID
INNER JOIN Region as D
  ON C.RegionID = D.RegionID
WHERE RegionDescription= 'Eastern'
GROUP BY a.EmployeeID;

-- 12. Give the name of products which were not ordered in 1996.

SELECT
  Products.ProductName
FROM Products
JOIN [Order Details]
  ON products.ProductID = [Order Details].ProductID
JOIN Orders
  ON orders.orderid = [Order Details].OrderID
WHERE Year(orders.OrderDate) <>  '1996'	