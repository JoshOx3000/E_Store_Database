-- Creation of Database
CREATE DATABASE e_shop;alter

use e_shop;


-- Creation of Table

CREATE TABLE Customers(
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE Categories(
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Products(
	product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE Orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE Order_Items(
	order_id INT,
    product_id INT,
    quantity INT DEFAULT 1,
    subtotal DECIMAL(10,2),
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments(
	payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_amount DECIMAL(10,2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Shippers(
	shipper_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Shipments(
	shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipper_id INT,
    shipment_date DATETIME,
    delivery_status VARCHAR(50) DEFAULT 'In Transit',
    FOREIGN KEY (shipper_id) REFERENCES Shippers(shipper_id)
);

-- Insert of Dummy Data 

INSERT INTO Customers (first_name, last_name, email, phone, city, state, country) 
VALUES
	('Alice', 'Johnson', 'alice.j@example.com', '555-0101', 'Seattle', 'WA', 'USA'),
	('Bob', 'Williams', 'bob.w@example.com', '555-0102', 'Miami', 'FL', 'USA'),
 	('Charlie', 'Brown', 'charlie.b@example.com', '555-0103', 'Toronto', 'ON', 'Canada'),
	('Diana', 'Prince', 'diana.p@example.com', '555-0104', 'London', NULL, 'UK'),
	('Eve', 'Adams', 'eve.a@example.com', '555-0105', 'Sydney', 'NSW', 'Australia'),
	('Frank', 'Miller', 'frank.m@example.com', '555-0106', 'Chicago', 'IL', 'USA'),
	('Grace', 'Lee', 'grace.l@example.com', '555-0107', 'Vancouver', 'BC', 'Canada'),
	('Henry', 'Taylor', 'henry.t@example.com', '555-0108', 'New York', 'NY', 'USA'),
	('Isabella', 'Martinez', 'isabella.m@example.com', '555-0109', 'Madrid', NULL, 'Spain'),
	('Jack', 'Wilson', 'jack.w@example.com', '555-0110', 'Auckland', 'AUK', 'New Zealand'),
	('Karen', 'Davis', 'karen.d@example.com', '555-0111', 'Melbourne', 'VIC', 'Australia');


    
  


INSERT INTO Categories (category_name) 
VALUES
	('Electronics'),
	('Apparel'),
	('Home Goods'),
	('Books'),
	('Sports Equipment'),
	('Beauty & Personal Care');


INSERT INTO Products (product_name, category_id, price, stock_quantity) 
VALUES
	('Laptop Pro', 1, 1200.00, 50),
	('Wireless Mouse', 1, 25.50, 200),
	('Cotton T-Shirt', 2, 19.99, 500),
 	('Denim Jeans', 2, 75.00, 150),
	('Coffee Maker', 3, 49.95, 80),
 	('Area Rug (Blue)', 3, 150.00, 30),
	('Fiction Novel', 4, 14.99, 120),
	('Cookbook Deluxe', 4, 29.99, 80),
	('Yoga Mat', 5, 35.00, 100),
	('Running Shoes', 5, 95.00, 75),
	('Face Cream', 6, 24.50, 200),
	('Shampoo 500ml', 6, 12.75, 300);

INSERT INTO Shippers (company_name, phone) VALUES
	('Swift Logistics', '800-111-2222'),
	('Global Freight', '800-333-4444'),
	('Express Parcel Co.', '800-555-6666'),
	('Oceanic Delivery', '800-777-8888');

INSERT INTO Orders (customer_id, order_date, order_status) 
VALUES
	(1, '2024-10-15 10:00:00', 'Shipped'),
	(2, '2024-10-16 14:30:00', 'Delivered'),
 	(4, '2024-10-18 09:15:00', 'Processing'),
	(6, '2024-10-20 11:45:00', 'Processing'),
	(7, '2024-10-21 13:00:00', 'Shipped'),
	(8, '2024-10-22 15:20:00', 'Delivered'),
	(9, '2024-10-23 09:50:00', 'Pending'),
	(10, '2024-10-24 16:10:00', 'Processing'),
	(11, '2024-10-25 18:30:00', 'Shipped');
    
INSERT INTO Order_Items (order_id, product_id, quantity, subtotal) 
VALUES
 	(1, 1, 1, 1200.00), -- Alice bought a Laptop Pro
 	(1, 2, 2, 51.00),   -- Alice bought 2 Wireless Mice
 	(2, 3, 5, 99.95),   -- Bob bought 5 T-Shirts
 	(3, 5, 1, 49.95),   -- Diana bought a Coffee Maker
 	(3, 6, 1, 150.00),  -- Diana bought an Area Rug
	(4, 7, 2, 29.98),     -- Frank bought 2 Fiction Novels
	(4, 9, 1, 35.00),     -- Frank bought 1 Yoga Mat
	(5, 8, 1, 29.99),     -- Grace bought a Cookbook
	(5, 10, 1, 95.00),    -- Grace bought Running Shoes
	(6, 11, 3, 73.50),    -- Henry bought 3 Face Creams
	(7, 12, 2, 25.50),    -- Isabella bought 2 Shampoos
	(8, 1, 1, 1200.00),   -- Jack bought Laptop Pro
	(8, 3, 2, 39.98),     -- Jack bought 2 Cotton T-Shirts
	(9, 5, 1, 49.95),     -- Karen bought Coffee Maker
	(9, 6, 1, 150.00);    -- Karen bought Area Rug


    
INSERT INTO Payments (order_id, payment_method, payment_amount, payment_date) 
VALUES
	(1, 'Credit Card', 1251.00, '2024-10-15 10:05:00'),
 	(2, 'PayPal', 99.95, '2024-10-16 14:35:00'),
 	(3, 'Credit Card', 199.95, '2024-10-18 09:20:00'),
	(4, 'Debit Card', 64.98, '2024-10-20 11:50:00'),
	(5, 'Credit Card', 124.99, '2024-10-21 13:05:00'),
	(6, 'PayPal', 73.50, '2024-10-22 15:25:00'),
	(7, 'Credit Card', 25.50, '2024-10-23 10:00:00'),
	(8, 'Credit Card', 1239.98, '2024-10-24 16:15:00'),
	(9, 'Debit Card', 199.95, '2024-10-25 18:35:00')
;



INSERT INTO Shipments (order_id, shipper_id, shipment_date, delivery_status) 
VALUES
 	(1, 1, '2024-10-15 16:00:00', 'In Transit'),
 	(2, 2, '2024-10-17 10:00:00', 'Delivered'),
	(4, 3, '2024-10-20 17:00:00', 'In Transit'),
	(5, 4, '2024-10-21 19:00:00', 'In Transit'),
	(6, 1, '2024-10-22 18:00:00', 'Delivered'),
	(7, 2, '2024-10-23 14:00:00', 'Delivered'),
	(8, 3, '2024-10-24 20:00:00', 'In Transit'),
	(9, 4, '2024-10-25 21:00:00', 'Processing');

    