--CREATE DATABASE Lab_9
--GO

USE Lab_9
GO

-- CONSTRAINT FUNCTIONS

CREATE FUNCTION dbo.validOrderQuantity(@quan int)
RETURNS VARCHAR(5)
AS
BEGIN
	IF @quan >= 50
		RETURN 'True'
	RETURN 'False'
END
GO

CREATE FUNCTION dbo.validEmail(@email varchar(50))
RETURNS VARCHAR(5)
AS
BEGIN
	IF @email LIKE '%@%.com'
		RETURN 'True'
	RETURN 'False'
END
GO


--TABLES

CREATE TABLE countries
(
	code INT PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	continent_name VARCHAR(20),

);
GO

-- Constraint function

CREATE FUNCTION dbo.checkCountryBan(@cCode int)
RETURNS VARCHAR(5)
AS
BEGIN
	IF (SELECT name FROM dbo.countries WHERE code = @cCode) IN ('india','India','INDIA')
		RETURN 'True'
	RETURN 'False'
END
GO

--Tables

CREATE TABLE users
(
	id INT PRIMARY KEY,
	fullname VARCHAR(30) NOT NULL,
	email VARCHAR(30) CONSTRAINT CheckvalidEmail CHECK (dbo.validEmail(email) = 'True') NOT NULL,
	gender VARCHAR(10) NOT NULL,
	date_of_birth VARCHAR(10) NOT NULL,
	country_code INT FOREIGN KEY REFERENCES countries(code),
	created_at VARCHAR(30) NOT NULL

);
GO

CREATE TABLE orders
(
	id INT PRIMARY KEY,
	user_id INT FOREIGN KEY REFERENCES users(id),
	status VARCHAR(20) NOT NULL,
	created_at VARCHAR(30) NOT NULL
);
GO

CREATE TABLE merchants
(
	id INT PRIMARY KEY,
	merchant_name VARCHAR(30) NOT NULL,
	admin_id INT FOREIGN KEY REFERENCES users(id),
	country_code INT FOREIGN KEY REFERENCES countries(code) CONSTRAINT checkBan CHECK (dbo.checkCountryBan(country_code) = 'False'),
	created_at VARCHAR(30) NOT NULL
);
GO

CREATE TABLE products
(
	id INT PRIMARY KEY,
	merchant_id INT FOREIGN KEY REFERENCES merchants(id),
	name VARCHAR(30) NOT NULL,
	price INT NOT NULL,
	status VARCHAR(20) NOT NULL,
	created_at VARCHAR(30) NOT NULL,
	stockQuntity INT NOT NULL
);
GO


-- Constraint function
CREATE FUNCTION dbo.checkProductAvailability(@pid int)
RETURNS VARCHAR(5)
AS
BEGIN
	IF (SELECT a.status FROM dbo.products a WHERE a.id = @pid) = 'A' 
		RETURN 'True'
	RETURN 'False'
END
GO

CREATE FUNCTION dbo.checkStockLim(@pid int,@quan int)
RETURNS VARCHAR(5)
AS
BEGIN
	IF (SELECT a.stockQuntity From dbo.products a where a.id = @pid) >= @quan
		RETURN 'True'
	RETURN 'False'
END
GO
---
CREATE TABLE orders_item
(
	order_id INT FOREIGN KEY REFERENCES orders(id),
	product_id INT FOREIGN KEY REFERENCES products(id) CONSTRAINT checkAvailability CHECK (dbo.checkProductAvailability(product_id) = 'True'),
	quantity INT CONSTRAINT validQuantity CHECK (dbo.validOrderQuantity(quantity) = 'True' ) NOT NULL,
	CONSTRAINT stockLim CHECK(dbo.checkStockLim(product_id,quantity) = 'True'),

);
GO
