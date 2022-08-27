-- Write a query that generates five copies of each employee row: Tables involved: HR.Employees and dbo.Nums 

SELECT E.empid, E.firstname, E.lastname, N.n FROM HR.Employees AS E CROSS JOIN dbo.Nums AS N  WHERE N.n <= 5 ORDER BY n, empid;

-- Write a query that returns a row for each employee and day in the range June 12, 2016 through June 16, 2016: Tables involved: HR.Employees and dbo.Nums 

SELECT E.empid, HIREDATE AS dt FROM HR.Employees AS E CROSS JOIN Nums AS D WHERE hiredate BETWEEN '2002-05-01 00:00:00.000' AND '2003-05-01 00:00:00.000';


--Explain what’s wrong in the following query, and provide a correct alternative:
SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate FROM Sales.Customers INNER JOIN Sales.Orders ON Customers.custid = Orders.custid;

--Excericse 4: Return US customers, and for each customer return the total number of orders and total quantities: Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
SELECT C.custid, C.companyname, O.orderid, O.orderdate FROM Sales.Customers AS C LEFT JOIN Sales.Orders AS O ON O.custid = C.custid;

--Exercise 5: Return customers and their orders, including customers who placed no orders: Tables involved: Sales.Customers and Sales.Orders 

SELECT Customers.custid, Orders.orderid FROM Sales.Customers INNER JOIN Sales.Orders  ON Customers.custid = Orders.custid;

--Exercise 6: Return customers who placed no orders: Tables involved: Sales.Customers and Sales.Orders 

SELECT C.custid, C.companyname FROM Sales.Customers AS C LEFT JOIN Sales.Orders AS O ON O.custid = C.custid WHERE O.orderid IS NULL;

-- Exercise 7: Return customers with orders placed on February 12, 2016, along with their orders: Tables involved: Sales.Customers and Sales.Orders 

SELECT C.custid, O.orderid, O.orderdate FROM Sales.Customers AS C INNER JOIN Sales.Orders As O ON O.custid=C.custid WHERE O.orderdate= '2007-02-12 00:00:00.000';

--Exercise 8: Write a query that returns all customers in the output, but matches them with their respective orders only if they were placed on February 12, 2016: Tables involved: Sales.Customers and Sales.Orders Desired output (abbreviated):

SELECT C.custid, C.companyname, O.orderid, O.orderdate FROM Sales.Customers AS C LEFT JOIN Sales.Orders AS O ON O.custid = C.custid WHERE O.orderdate = '2007-02-12 00:00:00.000' OR O.orderid IS NULL;

-- ex9

	