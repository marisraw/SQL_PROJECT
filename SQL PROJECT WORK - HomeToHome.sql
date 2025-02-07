-- Creating a database for ShopToShop
CREATE DATABASE ShopToShop;
-- END

-- Using a database of ShopToShop
USE ShopTOShop;
-- END


-- * * * * * * * * * * * * * * * * * * --


-- Creating a table for Customers
CREATE TABLE Customers
(
Customer_ID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Mobile VARCHAR(50) NOT NULL,
Place VARCHAR(50) NOT NULL
);
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


-- Select a Customers table
Select * From Customers;
-- END

-- * * * * * * * * * * * * * * * * * * --


-- Creating a table for Merchants
CREATE TABLE MERCHANTS
(
Merch_ID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Mobile VARCHAR(50) NOT NULL,
Place VARCHAR(50) NOT NULL
);
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

-- Select a merchants table
Select * From Merchants;
-- END 

-- * * * * * * * * * * * * * * * * * * --


-- Creating a table for orders
CREATE TABLE Orders
(
Order_ID INT PRIMARY KEY,
Item VARCHAR(50) NOT NULL,
Amount INT NOT NULL,
Customer_ID INT,
CONSTRAINT FK_Orders_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customers (Customer_ID)
ON DELETE SET NULL
);
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

-- Select a orders table
Select * From orders;
-- END 

-- * * * * * * * * * * * * * * * * * * --


-- Creating a table for Payments
CREATE TABLE Payments
(
Payment_ID INT PRIMARY KEY,
Payment_Mode VARCHAR(50) NOT NULL,
Status VARCHAR(50) NOT NULL,
Order_ID INT,
CONSTRAINT FK_Payments_Order_ID FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID)
ON DELETE SET NULL
);

-- Select a payments table
Select * From payments;
-- END 

-- * * * * * * * * * * * * * * * * * * --

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
ON DELETE SET NULL
);
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


-- Select a shippings table
Select * From shippings;
-- END 

-- * * * * * * * * * * * * * * * * * * --

-- Show all the table where created
SHOW TABLES;
-- END


-- * * * * * * * * * * * * * * * * * * --

-- !!! STORED PROCEDURES !!! --

-- 1 .  Show all customers ordered  quantity?

create view Show_all_customers_ordered_quantity
AS
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id;

select * from Show_all_customers_ordered_quantity;


-- END


-- 2 .  Who ordered by  more than one time or any?

Delimiter $$
create procedure Who_Orderd_By_More_than (in input_Order_Count int)
begin
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id
HAVING COUNT(orders.order_id) > input_Order_Count;
end $$
Delimiter ;

call Who_Orderd_By_More_than (1);

-- END


-- 3 .  Who ordered How much times

Delimiter $$
create procedure Who_Orderd_How_Much_time (in input_Order_Count int)
begin
SELECT customer_id, COUNT(order_id) AS Order_Counts
FROM orders
GROUP BY orders.customer_id
HAVING COUNT(orders.order_id) = input_Order_Count;
end $$
Delimiter ;

call Who_Orderd_How_Much_time  (1);

-- END


-- 4. Check any Customer's order delivery status
Delimiter $$
create procedure Customer_order_delivery_status  (in input_CUstomer_ID int)
begin
SELECT customer_id, (status) AS Delivery_status
FROM shippings
WHERE customer_id = input_CUstomer_ID; 
end $$
Delimiter ;

call Customer_order_delivery_status  (3);
-- END


-- 5. How many orders are not deliverd

create view Show_Count_of_orders_Not_deliverd
AS
SELECT COUNT(*) AS Pending_Orders
FROM Shippings
WHERE status = 'Pending';


select * from Show_Count_of_orders_Not_deliverd;
-- END


-- 6. Get list of pending counts by customers 

create view Order_Pending_Counts_BY_Customers
AS
SELECT Customer_id, COUNT(*) AS Pending_Counts
FROM Shippings
WHERE status = 'Pending'
GROUP BY Customer_id;

select * from  Order_Pending_Counts_BY_Customers;


-- 7. Get list of deliverd counts by customers 

create view Deliverd_Counts_BY_Customers 
AS
SELECT Customer_id, COUNT(*) AS Deliverd_Counts
FROM Shippings
WHERE status = 'Deliverd'
GROUP BY Customer_id;

select * from  Deliverd_Counts_BY_Customers;


-- 8 . Which items are pending

create view Which_items_are_pending
AS
SELECT orders.item, shippings.status
FROM orders
JOIN Shippings
ON Orders.order_id = Shippings.order_id
WHERE Shippings.status = 'Pending'
GROUP BY Shippings.order_ID;

select * from Which_items_are_pending;

-- END


-- 09 . total amount of all pending orders

create view total_amount_of_all_pending_orders 
AS
SELECT SUM(Orders.amount) AS Total_Pending_Amount
FROM orders
JOIN Shippings
ON Orders.order_id = Shippings.order_id
WHERE Shippings.status = 'Pending';

select * from total_amount_of_all_pending_orders;


-- 10 . Pending amount of each items

create view Pending_amount_of_each_items
AS
SELECT orders.item, SUM(Orders.amount) AS Pending_Amount
FROM orders
JOIN Shippings
ON Orders.order_id = Shippings.order_id
WHERE Shippings.status = 'Pending'
GROUP BY Shippings.order_ID;

select * from Pending_amount_of_each_items;
-- END


-- * * * * * * * * * * * * * * * * * * --


-- Scenarios of this table:-

-- 1 .  Show all customers ordered  quantity?
select * from Show_all_customers_ordered_quantity;

-- 2 .  Who ordered by  more than one time or any?
call Who_Orderd_By_More_than (1);

-- 3 .  Who ordered How much times
call Who_Orderd_How_Much_time  (1);

-- 4. Check any Customer's order delivery status
call Customer_order_delivery_status  (3);

-- 5. How many orders are not deliverd
select * from Show_Count_of_orders_Not_deliverd;

-- 6. Get list of pending counts by customers 
select * from  Order_Pending_Counts_BY_Customers;

-- 7. Get list of deliverd counts by customers 
select * from  Deliverd_Counts_BY_Customers;

-- 8 . Which items are pending
select * from Which_items_are_pending;

-- 09 . total amount of all pending orders
select * from total_amount_of_all_pending_orders;

-- 10 . Pending amount of each items
select * from Pending_amount_of_each_items;

new
