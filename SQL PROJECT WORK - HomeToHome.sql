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

-- Select a Customers table
Select * From Customers;
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

-- Select a merchants table
Select * From Merchants;
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

-- Select a orders table
Select * From orders;
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

-- Select a payments table
Select * From payments;
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

-- Select a shippings table
Select * From shippings;
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


-- Inserting data in Payments table
INSERT INTO Payments 
VALUES
(1, "UPI", "Successfull", 2),
(2, "UPI", "Successfull", 2),
(3, "Card", "Failure", 4),
(4, "Card", "Failure", 3),
(5, "UPI", "Successfull", 5);
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

-- !!! QUERIES !!! --

-- 1 .  Who ordered what quantity?
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id;
-- END


-- 2 .  Who order more than one time
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id
HAVING COUNT(orders.order_id) > 1;
-- END


-- 3 .  Who ordered two times
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id
HAVING COUNT(orders.order_id) = 2;
-- END


-- 4. 2nd Customer delivery status
SELECT customer_id, (status) AS Delivery_status
FROM shippings
WHERE customer_id = 2; 
-- END


-- 5. How many orders in pending status
SELECT COUNT(*) AS Pending_Orders
FROM Shippings
WHERE status = 'Pending';
-- END


-- 6. How many orders are succesfully delivered
SELECT COUNT(*) AS Pending_Orders
FROM Shippings
WHERE status = 'Deliverd';
-- END


-- 7. Get list of pending counts by customers 
SELECT Customer_id, COUNT(*) AS Pending_Counts
FROM Shippings
WHERE status = 'Pending'
GROUP BY Customer_id;


-- 8. Get list of deliverd counts by customers 
SELECT Customer_id, COUNT(*) AS Deliverd_Counts
FROM Shippings
WHERE status = 'Deliverd'
GROUP BY Customer_id;


-- 9. ///// UNCOVERED ///// Show the pending & deliverd counts by customers 
SELECT 
    Customer_id, 
    COUNT(CASE WHEN status = 'Pending' THEN 1 END) AS Pending_Orders, 
    COUNT(CASE WHEN status = 'Deliverd' THEN 1 END) AS Delivered_Orders
FROM Shippings
GROUP BY Customer_id;
-- END


-- Scenarios of this table:-
-- 1 .  Who ordered what quantity?
-- 2 .  Who order more than one time
-- 3 .  Who ordered two times
-- 4. 2nd Customer delivery status
-- 5. How many orders in pending status
-- 6. How many orders are succesfully delivered
-- 7. Get list of pending counts by customers 
-- 8. Get list of deliverd counts by customers 
-- 9. ///// UNCOVERED ///// Show the pending & deliverd counts by customers 




