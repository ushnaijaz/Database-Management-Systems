-- Q1: Write a query to report orders which were delayed shipped.
USE Northwind
SELECT COUNT(OrderID) AS ShippedLate FROM Orders WHERE ShippedDate > RequiredDate;

-- Q2: Our employees belong to how many countries. List the names.
SELECT DISTINCT COUNTRY FROM Employees

-- Q3: Is there any employee whose is not accountable?
SELECT CONCAT(FirstName,' ',LastName) FROM Employees WHERE ReportsTo is NULL;

-- Q4: List the names of products which have been discontinued. 
SELECT ProductID, ProductName FROM Products WHERE Discontinued = 1 ORDER BY ProductName;

-- Q5: List the IDs the orders on which discount was not provided 
SELECT OrderID FROM [Order Details] WHERE Discount=0;

-- Q6: Enlist the names of customers who have not specified their region.

SELECT ContactName FROM Customers WHERE Region IS NULL;

-- Q7: Enlist the names of customers along with contact number who either belongs to UK or USA.

SELECT ContactName, Phone FROM Customers WHERE Country IN ('UK','USA');

-- Q8: Report the names of companies who have provided their web page.

SELECT CompanyName FROM Suppliers WHERE HomePage IS NOT NULL;

-- Q9: In which countries, products were sold in year 1997
SELECT year(ShippedDate), ShipCountry FROM Orders WHERE ShippedDate between '1997-01-01' and '1997-12-31';

-- Q10: List the ids of customers whose orders were never shipped.

SELECT CUSTOMERID FROM Orders WHERE ShippedDate IS NULL;