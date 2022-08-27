-- DB HW 4
-- Answer these queries in the context of Northwind schema and solve them using subqueries only.
-- Submitted by : Ushna Ijaz (2019-CE-39)

-- 1. Give the names of customers whose orders were delayed. Your answer should have the following schema Customers(CustomerId, CustomerName)

SELECT CustomerID,ContactName as CustomerName
FROM Customers 
WHERE customerID in
   (SELECT CustomerID
	FROM Orders
	WHERE ShippedDate > RequiredDate);

-- 2. Give the products details with its supplier company. Products(ProductName, SupplierName)

SELECT ProductName,
	SupplierName = (
	SELECT CompanyName as SupplierName
	FROM [Suppliers] S
	Where s.SupplierID=p.SupplierID)
From Products P

--3. name of top products which have highest sale in the year 1998.****/
SELECT TOP(10) ProductName 
FROM Products 
WHERE ProductID IN(SELECT ProductID 
FROM [Order Details] OD 
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE YEAR(OrderDate)=1998) ) 


-- 4. the name of employees with its manager name.****/
SELECT M.FirstName AS EmployeeName,E.FirstName AS ManagerName 
FROM Employees AS E,Employees AS M
WHERE E.EmployeeID IN (SELECT EmployeeID FROM Employees WHERE E.EmployeeID=M.ReportsTo)

--5. the full names of managers who have less than two employees****/
SELECT CONCAT(FirstName,' ',LastName) 
FROM Employees 
GROUP BY FirstName,LastName 
HAVING COUNT(DISTINCT(ReportsTo))<2

--6 List all the products whose price is more than average price.****/
SELECT ProductName,UnitPrice 
FROM Products 
WHERE UnitPrice>(SELECT AVG(UnitPrice) FROM Products) ORDER BY UnitPrice

--7. second highest priced product without using TOP statement****/
SELECT ProductName,UnitPrice 
FROM Products AS P 
WHERE (SELECT COUNT(DISTINCT ProductName) FROM Products WHERE P.UnitPrice<=UnitPrice)=2

--8. Are there any employees who are elder than their managers?****/
SELECT CONCAT(A.FirstName,' ',A.LastName) AS EmployeeName, CONCAT(B.FirstName,' ',B.LastName) as ManagerName, year(getdate())-year(a.BirthDate) 
as EmployeeAge, year(getdate())-year(b.BirthDate) as ManagerAge
FROM Employees A, Employees B 
WHERE A.ReportsTo=B.EmployeeID AND A.BirthDate<B.BirthDate

--9. List the names of products which were ordered on 8th August 1997.****/
SELECT Productname 
FROM Products 
WHERE ProductID IN(SELECT ProductID FROM [Order Details] WHERE  OrderID IN (SELECT OrderID FROM Orders WHERE OrderDate='1997-8-8'))

--10 List the names of suppliers whose supplied products were ordered in 1997.****/
SELECT CompanyName FROM Suppliers WHERE SupplierID IN (SELECT SupplierID FROM Products WHERE ProductID IN (SELECT ProductID FROM [Order Details] 
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE YEAR(OrderDate)=1997)))

--11. How many employees are assigned to Eastern region. Give count.****/
SELECT COUNT(Firstname) AS Employees_in_Eastern_Region 
FROM Employees 
WHERE EmployeeID IN (SELECT DISTINCT(EmployeeID) FROM EmployeeTerritories WHERE TerritoryID IN (SELECT TerritoryID FROM Territories WHERE RegionID=1))

--12. Give the name of products which were not ordered in 1996.****/
SELECT DISTINCT(ProductName) 
FROM Products 
WHERE ProductID IN (SELECT ProductID FROM [Order Details] WHERE OrderID IN (SELECT OrderID FROM Orders WHERE YEAR(OrderDate)<>1996)) ORDER BY ProductName ASC