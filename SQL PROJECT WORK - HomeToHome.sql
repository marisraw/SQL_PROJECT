-- Creating a database for ShopToShop
CREATE DATABASE ShopToShop;
-- END


-- Using a database of ShopToShop
USE ShopTOShop;
-- END


-- Creating a table for Customers
CREATE TABLE Customers
(
Customer_ID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Mobile VARCHAR(50) NOT NULL,
Place VARCHAR(50) NOT NULL
);
-- END


-- Creating a table for Merchants
CREATE TABLE MERCHANTS
(
Merch_ID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Mobile VARCHAR(50) NOT NULL,
Place VARCHAR(50) NOT NULL
);
-- END


-- Creating a table for orders
CREATE TABLE Orders
(
Order_ID INT PRIMARY KEY,
Item VARCHAR(50) NOT NULL,
Amount INT NOT NULL,
Customer_ID INT,
CONSTRAINT FK_Orders_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customers (Customer_ID)
);
-- END


-- Creating a table for Payments
CREATE TABLE Payments
(
Payment_ID INT PRIMARY KEY,
Payment_Mode VARCHAR(50) NOT NULL,
Status VARCHAR(50) NOT NULL,
Order_ID INT,
CONSTRAINT FK_Payments_Order_ID FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID)
);
-- END


-- Creating a table for Shippings
CREATE TABLE Shippings
(
Shippment_ID INT PRIMARY KEY,
Status VARCHAR(50) NOT NULL,
Customer_ID INT,
CONSTRAINT FK_Shippings_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customers (Customer_ID),
Merch_ID INT,
CONSTRAINT FK_Shippings_Merch_ID FOREIGN KEY (Merch_ID) REFERENCES Merchants (Merch_ID),
Order_ID INT,
CONSTRAINT FK_Shippings_Order_ID FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID)
);
-- END


-- Show all the table where created
SHOW TABLES;
-- END


-- Inserting data in Customers table
INSERT INTO Customers 
VALUES
(1, "Arun", "9785265455", "Chennai"),
(2, "Praksh", "5896544555", "Vellore"),
(3, "Ananthi", "8965432168", "Thirunelveli"),
(4, "Selvam", "7856315458", "kanchipuram"),
(5, "Kumar", "7835642136", "Trichy");
-- END


-- Inserting data in Orders table
INSERT INTO Orders 
VALUES
(1, "Mango", 500, 2),
(2, "Brinjal", 250, 2),
(3, "Carrot", 100, 4),
(4, "Beetroot", 725, 3),
(5, "Tomatos", 900, 1);
-- END


-- Inserting data in Merchants table
INSERT INTO Merchants 
VALUES
(1, "Anitha", "354644865", "Tenkasi"),
(2, "Vinoth", "79956644", "Nelloor"),
(3, "Sam", "856254587", "Ooty"),
(4, "Aravind", "98785665", "Avinasi"),
(5, "Suguna", "3654854887", "Madurai");
-- END


-- -- Inserting data in Shippings table
INSERT INTO Shippings 
VALUES
(1, "Pending", 1, 5, 4),
(2, "Pending", 2, 3, 2),
(3, "Deliverd", 3, 4, 1),
(4, "Deliverd", 1, 3, 2),
(5, "Pending", 2, 4, 3);
-- END


-- Select and view all the tables
Select*
From Customers;

Select*
From Orders;

Select*
From Merchants;

Select*
From payments;

Select*
From Shippings;
-- END







