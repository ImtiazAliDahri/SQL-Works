


-- Introduction
/*
This project aims to design and implement a comprehensive Inventory Management System using sample data, laying the groundwork for future big data applications. 
By working with a small dataset, I intend to master the fundamentals of data analysis, querying, and database design, progressing incrementally towards handling larger,
 more intricate data. The primary objective is to create a robust system that effectively tracks products, suppliers, orders, and order details, showcasing advanced SQL
 features, querying capabilities, and database design principles.
*/



-- Create database called "InventoryDB"


CREATE DATABASE InventoryDB;

USE InventoryDB;
-- Table for storing product details
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);
-- Table for storing supplier details
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255)
);
-- Table for storing orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE,
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
-- Table for storing order details
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


--  Insert Sample Data



-- Products table
INSERT INTO Products (ProductName, Category, Price, StockQuantity) VALUES
('iPhone 14', 'Smartphones', 999.99, 500),
('Samsung TV', 'Electronics', 1299.99, 200),
('Nike Air Max', 'Footwear', 129.99, 300),
('Adidas T-Shirt', 'Apparel', 19.99, 400),
('Sony Headphones', 'Accessories', 99.99, 250),
('PlayStation 5', 'Gaming', 499.99, 150),
('Apple Watch', 'Smartwatches', 399.99, 100),
('Canon Camera', 'Photography', 799.99, 50),
('HP Laptop', 'Computers', 699.99, 200),
('Under Armour Shoes', 'Footwear', 89.99, 350);

-- Suppliers table
INSERT INTO Suppliers (SupplierName, ContactInfo) VALUES
('Apple Inc.', '123-456-7890'),
('Samsung Electronics', '987-654-3210'),
('Nike Corporation', '555-123-4567'),
('Adidas AG', '666-789-0123'),
('Sony Corporation', '777-890-1234'),
('PlayStation', '888-901-2345'),
('Canon USA', '999-000-1111'),
('HP Inc.', '222-333-4444'),
('Under Armour', '444-555-6666');

-- Orders table
INSERT INTO Orders (OrderDate, SupplierID) VALUES
('2024-09-01', 1),
('2024-09-02', 2),
('2024-09-03', 3),
('2024-09-04', 4),
('2024-09-05', 5),
('2024-09-06', 6),
('2024-09-07', 7),
('2024-09-08', 8),
('2024-09-09', 9);

-- OrderDetails table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 10, 999.99),
(2, 2, 5, 1299.99),
(3, 3, 20, 129.99),
(4, 4, 30, 19.99),
(5, 5, 15, 99.99),
(6, 6, 10, 499.99),
(7, 7, 5, 399.99),
(8, 8, 2, 799.99),
(9, 9, 25, 89.99);

select * from Products;
select * from suppliers;
select * from orders;
select * from orderdetails;


--  Queries



-- Get products with price above $500
SELECT * FROM Products WHERE Price > 500;

-- Get suppliers with contact info containing '555'
SELECT * FROM Suppliers WHERE ContactInfo LIKE '%555%';

-- Get orders placed after '2024-09-05'
SELECT * FROM Orders WHERE OrderDate > '2024-09-05';

-- Get products with stock quantity between 100 and 500
SELECT * FROM Products WHERE StockQuantity BETWEEN 100 AND 500;

-- Get total sales amount per supplier
SELECT s.SupplierName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Suppliers s
JOIN Orders o ON s.SupplierID = o.SupplierID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY s.SupplierName;


-- Get products from the 'Gaming' category
SELECT * FROM Products WHERE Category = 'Gaming';

-- Get products with no orders placed
SELECT * FROM Products WHERE ProductID NOT IN (SELECT ProductID FROM OrderDetails);

-- Get average sales amount per order
SELECT AVG(TotalSales) AS AverageSales
FROM (
SELECT OrderID, SUM(Quantity * UnitPrice) AS TotalSales
FROM OrderDetails
GROUP BY OrderID
) AS Subquery;




-- Advanced Queries:



--  JoinOrders, Suppliers, and OrderDetails
SELECT o.OrderID, o.OrderDate, s.SupplierName, od.ProductID, od.Quantity, od.UnitPrice
FROM Orders o
JOIN Suppliers s ON o.SupplierID = s.SupplierID
JOIN OrderDetails od ON o.OrderID = od.OrderID;

-- Join Products, OrderDetails, and Orders
SELECT p.ProductName, od.Quantity, od.UnitPrice, o.OrderID, o.OrderDate
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID;

-- Join Suppliers, Orders, OrderDetails, and Products
SELECT s.SupplierName, o.OrderID, o.OrderDate, p.ProductName, od.Quantity, od.UnitPrice
FROM Suppliers s
JOIN Orders o ON s.SupplierID = o.SupplierID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Join Orders and OrderDetails with product name
SELECT o.OrderID, o.OrderDate, p.ProductName, od.Quantity, od.UnitPrice
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;



-- This query will provide
-- 1. Join Products and OrderDetails tables on ProductID
-- 2. Group results by ProductID and ProductName
-- 3. Calculate total sales for each product using SUM(Quantity * UnitPrice)
-- 4. Filter results to include only products with total sales above $1000
 
-- Products with total sales above $1,000
SELECT p.ProductID, p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalSales
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity * od.UnitPrice) > 1000;



-- Conclusion
/*
This SQL project demonstrates the creation of a comprehensive inventory management system.
It includes tables for Products, Suppliers, Orders, and OrderDetails, with relationships established through foreign keys.
Sample data is inserted into each table, and various queries are executed to retrieve specific information.
Queries include filtering products by price and category, retrieving supplier information, and calculating total sales per supplier.
Joins are performed to combine data from multiple tables, providing insights into orders, products, and suppliers.
The final query identifies products with total sales exceeding $1000, showcasing the system's ability to analyze sales data.
Overall, this project showcases a robust inventory management system with advanced querying capabilities.
*/
