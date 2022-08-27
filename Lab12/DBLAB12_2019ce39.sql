/*SUBMITTED BY: USHNA IJAZ
		2019-CE-39  */


/* Q1: Create 10Multiplesof10 table using While loop instead of Go N.*/

USE Lab12

CREATE TABLE multiplesof10
(
Multiples INT,
)

DECLARE @mults INT;
SET @mults = 10;
    
WHILE @mults<= 100
BEGIN
   INSERT INTO multiplesof10 VALUES(@mults)
   SET @mults = @mults + 10;
END;

/* Q2: Display the names of the first 50 Products that have available
Stock (Not 0 in quantity in Stock) using While. */

DECLARE @count INT
SET @count = 0
    
WHILE @count< 1
BEGIN
   SELECT top 50 ProductName FROM Products Where UnitsInStock != 0
   ORDER BY ProductID
   SET @count = @count + 1;
END;

/* Q3: Use Case to display "Subordinate" for the employees that report to someone and "Superior" for those
who report to no other employee. */

SELECT CONCAT(FirstName,' ', LastName) as EmployeeName,
	CASE WHEN ReportsTo IS NOT NULL THEN 'Subordinate'
    ELSE 'Superior'
END 
FROM Employees

-- STORED PROCEDURES

/* q1- Create a function that takes a number as input and calculates and displays its first 10 multiples. Use
the function to calculate tables of 1, 2, 3, 4, 5 (Do not write the same query 5 times, find a more
efficient way). */


DECLARE @n INT = 6;


;WITH storedproc AS
(
    SELECT TOP(10) Value = ROW_NUMBER() 
    OVER (ORDER BY[object_id]) FROM SYS.ALL_OBJECTS
)
SELECT Value,
       @n AS n,
       Value * @n AS Result
FROM   storedproc;


/* Create both, a Procedure and a function that takes order ID as input and calculates the total bill for
each order of that ID and then displays the bills for each order. */

-- Procedure
USE Northwind

DROP PROCEDURE IF EXISTS price;
GO
CREATE PROCEDURE price (@orderid INT)
AS BEGIN
  SELECT SUM(UnitPrice*Quantity*(1-Discount)) as TotalPrice
  FROM [Order Details] 
  WHERE Orderid = @orderid
  Group By OrderID
  END;	

EXEC price 10248;

-- FUNCTION 

CREATE FUNCTION Totalprice (
    @orderID INT
)
RETURNS TABLE
AS
RETURN
  SELECT SUM(UnitPrice*Quantity*(1-Discount)) as TotalPrice
  FROM [Order Details] 
  WHERE Orderid = '10248'
  Group By OrderID;

-- Error Handling:

/*Use error handling to catch the error from the third question in 
the variables section using SET i.e.Use SET statement to display 
the variable that has the quantity of Product for Order ID 10248. */

Declare @val1 int;  
Declare @val2 int;  
BEGIN TRY  
Set @val1= '10248';  
Set @val2=@val1/0; /* Error Occur Here */  
END TRY  
BEGIN CATCH
select sum(quantity) as totalquantity from dbo.[Order Details] where 
OrderID = @val1
group by OrderID
Print 'Error Occur that is:'  
Print Error_Message()  
END CATCH 

/* 2. Define a procedure "ErrorInfo" that displays all error information. 
Upon catching the error, the ErrorInfo procedure should be called.*/


Declare @val1 int;  
Declare @val2 int;  
BEGIN TRY  
Set @val1= '10248';  
Set @val2=@val1/0; /* Error Occur Here */  
END TRY  
BEGIN CATCH
Print 'Error Occur that is:'  
Print Error_Message()  
END CATCH  
